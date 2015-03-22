# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uber_api/version'

Gem::Specification.new do |spec|
  spec.name          = "uber_api"
  spec.version       = UberApi::VERSION
  spec.authors       = ["Abhijeet Kalyan"]
  spec.email         = ["abhijeetkalyan@gmail.com"]
  spec.summary       = %q{Ruby client for the Uber API.}
  spec.description   = %q{Ruby client for the Uber API. Supports all endpoints, but please read the oauth_example on Github for how to generate bearer tokens}
  spec.homepage      = "https://github.com/abhijeetkalyan/uber_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "json"
  
end
