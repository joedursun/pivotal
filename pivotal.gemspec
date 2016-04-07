# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal/version'

Gem::Specification.new do |spec|
  spec.name          = 'pivotal'
  spec.version       = Pivotal::VERSION
  spec.authors       = ['Joe Dursun']
  spec.email         = ['joe@clockwisemd.com']

  spec.summary       = %q{API wrapper for Pivotal API V5}
  spec.description   = %q{API wrapper for Pivotal API V5. No gem dependencies. Just plain ruby.}
  spec.homepage      = 'https://github.com/joedursun/pivotal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
