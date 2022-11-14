# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "creek-jekyll-theme"
  spec.version       = "0.1.0"
  spec.authors       = ["Creek Service - Big Andy Coates"]
  spec.email         = ["8012398+big-andy-coates@users.noreply.github.com"]

  spec.summary       = "A Jekyll theme gem, indented only for the Creek website."
  spec.homepage      = "https://github.com/creek-service/creek-jekyll-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|_config\.yml)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.3"
end
