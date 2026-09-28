# creek-jekyll-theme

The Jekyll theme used by the [Creek site](https://www.creekservice.org).

## Installation

Add this line to your Jekyll site's `Gemfile`:

```ruby
gem "creek-jekyll-theme"
```

And add this line to your Jekyll site's `_config.yml`:

```yaml
theme: creek-jekyll-theme
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install creek-jekyll-theme
```

## Usage

The theme is a fork of [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes), with a load of shared
defaults, images, data, and customisations.

### `include_snippet` Liquid tag

The gem also bundles an `include_snippet` Liquid tag, which includes a named snippet of text from another file
into a page or post - handy for keeping code samples in docs in sync with the actual source. It's a drop-in
replacement for the [`jekyll-include_snippet`](https://github.com/tomdalling/jekyll-include_snippet) gem, with
one behavioural fix: an explicit `from <path>` on a tag now always takes precedence over a page's
`snippet_source` front matter default, rather than being silently overridden by it.

To use it, add this gem to the `jekyll_plugins` group in your `Gemfile` instead of (or as well as, if you're
also using the theme) adding it as a plain gem, so Jekyll requires it as a plugin:

```ruby
group :jekyll_plugins do
  gem "creek-jekyll-theme"
end
```

If you were previously using the `jekyll-include_snippet` gem directly, remove it - `include_snippet` tags in
your markdown work unchanged, no content needs to change.

Usage is otherwise the same as the gem it replaces. Put `begin-snippet`/`end-snippet` comments around the code
you want to include:

```ruby
# begin-snippet: my_snippet
def my_method
  ...
end
# end-snippet
```

Then include it from a page or post:

```liquid
{% include_snippet my_snippet from path/to/file.rb %}
```

Or set a default source file in front matter, and override it per-tag when needed:

```yaml
---
snippet_source: "path/to/file.rb"
snippet_comment_prefix: "//" # defaults to "#"
---
```

See the source of [`lib/creek-jekyll-theme/include_snippet.rb`](lib/creek-jekyll-theme/include_snippet.rb) for
full documentation.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creek-service/creek-jekyll-theme. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Development

To set up your environment to develop this theme, run `bundle install`.

This theme is set up just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open 
your browser at `http://localhost:4000`. This starts a Jekyll server using this theme. Add pages, documents, data, etc. 
like normal to test the theme's contents. As you make modifications to the theme and to your content, 
the site will regenerate, and you should see the changes in the browser after a refresh, just like normal.

When the theme is released, only the files in `_data`, `_layouts`, `_includes`, `_sass`, `assets` and `lib` tracked with Git will be bundled.
To add a custom directory to the theme-gem, please edit the regexp in `creek-jekyll-theme.gemspec` accordingly.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Building locally

To build and install locally from source, follow these steps:

1. Update version number in the [gemspec](creek-jekyll-theme.gemspec).
2. Run: 
   ```shell
   rm creek-jekyll-theme-*.gem
   gem build creek-jekyll-theme.gemspec
   gem install creek-jekyll-theme-*.gem
   ```

## Releasing

Releases will automatically be built and pushed to [Ruby Gems](https://rubygems.org/gems/creek-jekyll-theme) when
a release tag is pushed to git. 
Currently, the process of updating the gemspec version and pushing a matching git tag is a manual process:

1. Update version number in the [gemspec](creek-jekyll-theme.gemspec).
2. Run the following to pick up the new version:
   ```shell
   bundle update
   ```
3. Commit & push
   ```shell
   git add -A
   git commit -m "Bump release version"
   git push 
   ```
4. Push a new git tag, matching the new version in the gemspec:
   ```shell
   GEM_VERSION=$(sed -nr 's/.*spec\.version[^"]*"([1-9.]+)"/\1/p' creek-jekyll-theme.gemspec)
   git tag v$GEM_VERSION
   git push --tag
   ```

### Dropping a release

```shell
gem yank creek-jekyll-theme -v VERSION_TO_DROP  
```