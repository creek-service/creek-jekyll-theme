# frozen_string_literal: true

# Liquid tag that includes a named snippet of text from another file into a page or post.
#
# Bundled with this theme so Creek's docs sites don't need to depend on the separate
# `jekyll-include_snippet` gem, and so a bug in that gem's precedence rules can be fixed here
# without waiting on an upstream release.
#
# Ported from https://github.com/tomdalling/jekyll-include_snippet (MIT licensed,
# Copyright (c) Tom Dalling), with one behavioural fix: an explicit `from <path>` on the tag
# itself now takes precedence over a page's `snippet_source` front matter default. Previously,
# setting `snippet_source` in front matter silently overrode every `from <path>` on that page,
# no matter what path was given, which broke pages that need to pull named snippets from more
# than one source file.
#
# Usage:
#
#   Put `begin-snippet`/`end-snippet` comments around the code you want to include:
#
#     # begin-snippet: my_snippet
#     def my_method
#       ...
#     end
#     # end-snippet
#
#   Then include it from a page or post:
#
#     {% include_snippet my_snippet from path/to/file.rb %}
#
#   If every `include_snippet` tag on a page reads from the same file, set a default in the
#   page's front matter instead of repeating `from <path>` on every tag:
#
#     ---
#     snippet_source: "path/to/file.rb"
#     ---
#     {% include_snippet my_snippet %}
#
#   An explicit `from <path>` always overrides the front matter default for that one tag, so
#   the two forms can be mixed freely on the same page.
#
#   For non-Ruby source, set the comment prefix used to find the begin/end markers, either
#   per-page via front matter:
#
#     ---
#     snippet_comment_prefix: "//"
#     ---
#
#   The default comment prefix is `#`.
module CreekJekyllTheme
  module IncludeSnippet
    DEFAULT_COMMENT_PREFIX = "#"

    class LiquidTag < Liquid::Tag
      def initialize(tag_name, arg_str, tokens)
        super
        @snippet_name, @source_path = arg_str.split(/\sfrom\s/).map(&:strip)
      end

      def render(context)
        source_path = source_path_for(context)
        source = File.read(source_path)
        extractor = Extractor.new(comment_prefix: comment_prefix_for(context))
        snippets = extractor.(source)
        snippets.fetch(@snippet_name) do
          raise "Snippet not found: #{@snippet_name.inspect}\n    in file: #{source_path}"
        end
      end

      private

      # An explicit `from <path>` on the tag always wins. Only fall back to the page's
      # `snippet_source` front matter default when the tag doesn't specify its own path.
      def source_path_for(context)
        result = @source_path || get_option(:snippet_source, context)

        raise "No source path provided for snippet: #{@snippet_name}" if result.nil?

        result
      end

      def comment_prefix_for(context)
        get_option(:snippet_comment_prefix, context) || DEFAULT_COMMENT_PREFIX
      end

      def get_option(option_name, context)
        page = context["page"]
        page && page[option_name.to_s]
      end
    end

    class Extractor
      attr_reader :comment_prefix

      def initialize(comment_prefix:)
        @comment_prefix = comment_prefix
      end

      def call(source)
        everything = Snippet.new(name: "everything", indent: 0)
        all_snippets = []
        active_snippets = []

        source.each_line.each_with_index do |line, lineno|
          case line
          when begin_regex
            active_snippets << Snippet.new(name: $2.strip, indent: $1.length)
          when end_regex
            raise missing_begin_snippet(lineno) if active_snippets.empty?

            all_snippets << active_snippets.pop
          else
            (active_snippets + [everything]).each do |snippet|
              snippet.lines << line
            end
          end
        end

        (all_snippets + [everything])
          .map { |s| [s.name, s.dedented_text] }
          .to_h
      end

      private

      def begin_regex
        %r{
          (\s*)           # optional whitespace (indenting)
          #{Regexp.quote(comment_prefix)} # the comment prefix
          \s*             # optional whitespace
          begin-snippet:  # magic string for beginning a snippet
          (.+)            # the remainder of the line is the snippet name
        }x
      end

      def end_regex
        %r{
          \s*          # optional whitespace (indenting)
          #{Regexp.quote(comment_prefix)} # the comment prefix
          \s*          # optional whitespace
          end-snippet  # Magic string for ending a snippet
        }x
      end

      def missing_begin_snippet(lineno)
        <<~END_ERROR
          There was an `end-snippet` on line #{lineno}, but there doesn't
          appear to be any matching `begin-snippet` line.

          Make sure you have the correct `begin-snippet` comment --
          something like this:

              # begin-snippet: MyRadCode

        END_ERROR
      end

      class Snippet
        attr_reader :name, :indent, :lines

        def initialize(name:, indent:)
          @name = name
          @indent = indent
          @lines = []
        end

        def dedented_text
          lines
            .map { |line| dedent(line) }
            .join
            .rstrip
        end

        def dedent(line)
          if line.length >= indent
            line[indent..-1]
          else
            line
          end
        end
      end
    end
  end
end

Liquid::Template.register_tag("include_snippet", CreekJekyllTheme::IncludeSnippet::LiquidTag)
