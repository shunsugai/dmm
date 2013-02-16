# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dmm/version'

Gem::Specification.new do |gem|
  gem.name          = "dmm"
  gem.version       = Dmm::VERSION
  gem.authors       = ["Shun Sugai"]
  gem.email         = ["sugaishun@gmail.com"]
  gem.description   = "Ruby wrapper for DMM Web Service API ver2"
  gem.summary       = "Ruby wrapper for DMM Web Service API ver2"
  gem.homepage      = "https://github.com/shunsugai/dmm"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'nokogiri', '~> 1.5.6'
  gem.add_development_dependency 'rspec'
end