# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'send_gmail/version'

Gem::Specification.new do |spec|
  spec.name          = 'send_gmail'
  spec.version       = SendGmail::VERSION
  spec.authors       = ['hatappi']
  spec.email         = ['hata.yusaku.1225@gmail.com']

  spec.summary       = 'incoming, outgoing  mail'
  spec.description   = 'incoming, outgoing mail by google gmail api'
  spec.homepage      = 'https://github.com/hatappi/send_gmail'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'google-api-client'
  spec.add_development_dependency 'mail'
end
