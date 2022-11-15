module Jekyll
  module Tags
    class IncludeSnippetTag < FlexibleInclude
      def render(liquid_context)
        @helper.liquid_context = liquid_context
        @token = @helper.parameter_specified? "token"

        super(liquid_context)
      end

      def read_file(file)
        @token ? snippet(super(file)) : super(file)
      end

      def snippet(contents)
        matched = contents.match /.*#{Regexp.escape("#{@token}-start")}(?<snip>.*)#{Regexp.escape("#{@token}-end")}.*/m
        matched ? matched[:snip] : contents
      end
    end
  end
end

Liquid::Template.register_tag("include_snippet", Jekyll::Tags::IncludeSnippetTag)

