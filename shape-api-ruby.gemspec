lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shape-api/version"

Gem::Specification.new do |gem|
  gem.add_development_dependency "bundler", "~> 2.0"
  gem.add_dependency "json_api_client", "~> 1.9"
  gem.authors       = ["Josh Schwartzman"]
  gem.email         = ["jschwartzman@ideo.com"]
  gem.description   = "IDEO Ruby Token utilities."
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/ideo/shape-api-ruby"
  gem.licenses      = %w[MIT]
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")
  gem.name          = "shape-api-ruby"
  gem.require_paths = %w[lib]
  gem.version       = ShapeApi::VERSION
end
