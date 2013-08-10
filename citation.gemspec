# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'citation/version'

Gem::Specification.new do |spec|
  spec.name          = "citation"
  spec.version       = Citation::VERSION
  spec.authors       = ["Todorus"]
  spec.email         = ["todorus@todorus.com"]
  spec.description   = "Gem for citing works. Currently only an APA style exporter is bieng developed. http://library.williams.edu/citing/styles/apa.php"
  spec.summary       = "Gem for citing works."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'guard-rspec'
end
