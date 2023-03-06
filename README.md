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

When the theme is released, only the files in `_dat`, `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.
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