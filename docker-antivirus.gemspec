# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker/antivirus/version'

Gem::Specification.new do |spec|
  spec.name          = 'docker-antivirus'
  spec.version       = Docker::Antivirus::VERSION
  spec.authors       = ['Wassim DHIF']
  spec.email         = ['wassimdhif@gmail.com']

  spec.summary       = 'Docker Antivirus with ClamAV and Atomic'
  spec.description   = 'Check your Docker Images for viruses with ClamAV'
  spec.homepage      = 'https://github.com/wdhif/docker-antivirus'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'json_pure'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
