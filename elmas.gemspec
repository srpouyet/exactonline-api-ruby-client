# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elmas/version'

Gem::Specification.new do |spec|
  spec.name          = "elmas"
  spec.authors       = ["Marthyn"]
  spec.email         = ["Marthyn@hoppinger.nl"]

  spec.summary       = %q{API wrapper for Exact Online}
  spec.homepage      = "https://www.hoppinger.com"
  spec.licenses      = %w(MIT)

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)
  spec.version       = Elmas::Version

  spec.add_dependency "faraday", [">= 0.8", "< 0.10"]
  spec.add_dependency "faraday_middleware", [">= 0.8", "< 0.10"]
  spec.add_dependency "oauth2", "1.0.0"
  # spec.add_dependency "mechanize", "2.7.3"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency("rspec", "~> 2.4")
  spec.add_development_dependency("pry", ">= 0.0")
  spec.add_development_dependency("webmock", "~> 1.6")
  spec.add_dependency("faraday-detailed_logger")
end
