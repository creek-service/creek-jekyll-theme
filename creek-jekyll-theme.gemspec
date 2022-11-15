# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "creek-jekyll-theme"
  spec.version       = "0.4.0"
  spec.authors       = ["Creek Service - Big Andy Coates"]
  spec.email         = ["8012398+big-andy-coates@users.noreply.github.com"]

  spec.summary       = "A Jekyll theme gem, indented only for the Creek website."
  spec.homepage      = "https://github.com/creek-service/creek-jekyll-theme"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files                   = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(_data|_includes|_layouts|_plugins|_sass|assets|LICENSE|README'.md|_config\.yml|404\.md)!i)
  end

  spec.add_runtime_dependency "jekyll", ">= 4.3", "< 5.0"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-sitemap", "~> 1.3"
  spec.add_runtime_dependency "jekyll-gist", "~> 1.5"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.1"
  spec.add_runtime_dependency "jekyll-include-cache", "~> 0.1"
  spec.add_runtime_dependency "jekyll-algolia", "~> 1.7"

  # Required by _plugins/flexible_include
  spec.add_runtime_dependency "jekyll_plugin_logger", "~> 2.0"
  spec.add_runtime_dependency "key-value-parser", "~> 0.0.2"

  spec.add_runtime_dependency "jemoji", "~> 0.12.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 12.3.3"
end