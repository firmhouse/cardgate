# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cardgate/version'

Gem::Specification.new do |spec|
  spec.name          = "cardgate"
  spec.version       = Cardgate::VERSION
  spec.authors       = ["Youri van der Lans"]
  spec.email         = ["youri@itflows.nl"]
  spec.summary       = "Cardgate REST API client"
  spec.description   = "Provides an easy way to communicate with the cardgate REST API"
  spec.homepage      = "https://github.com/yourivdlans/cardgate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"

  spec.add_dependency "faraday", "~> 0.8"
  spec.add_dependency "faraday_middleware", "~> 0.9"
end
