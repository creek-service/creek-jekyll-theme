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
defaults, images, data, etc.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creek-service/creek-jekyll-theme. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Development

To set up your environment to develop this theme, run `bundle install`.

Your theme is setup just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open 
your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. 
like normal to test your theme's contents. As you make modifications to your theme and to your content, 
your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When your theme is released, only the files in `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.
To add a custom directory to your theme-gem, please edit the regexp in `creek-jekyll-theme.gemspec` accordingly.

## License

The theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Releasing

Manual process for now. Automation covered by [issue 1](https://github.com/creek-service/creek-jekyll-theme/issues/1)

1. Delete previous built versions:
   ```shell
   rm -f creek-jekyll-theme-*.gem
   ```
2. Update version number in the [gemspec](creek-jekyll-theme.gemspec).
3. Commit & push
   ```shell
   git add -A
   git commit -m "Bump release version"
   git push 
   ```
4. Push a new git tag for the version:
   ```shell
   git tag v?.?.? <-- set version
   git push --tag
   ```
5. Build the gem:
   ```shell
   gem build creek-jekyll-theme.gemspec
   ```
6. Install locally for testing
   ```shell
   gem install creek-jekyll-theme-*.gem
   ```
7. Release the gem:
   ```shell
   gem push creek-jekyll-theme-*.gem
   ```

### Dropping a release

```shell
gem yank creek-jekyll-theme -v VERSION_TO_DROP  
```