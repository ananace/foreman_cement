# frozen_string_literal: true

require_relative 'lib/foreman_cement/version'

Gem::Specification.new do |spec|
  spec.name        = 'foreman_cement'
  spec.version     = ForemanCement::VERSION
  spec.authors     = ['Alexander Olofsson']
  spec.email       = ['alexander.olofsson@liu.se']

  spec.summary     = 'Send encountered exceptions and tracing to sentry.'
  spec.description = spec.summary
  spec.homepage    = 'https://github.com/ananace/foreman_cement'
  spec.license     = 'GPL-3.0'

  spec.files = Dir['{app,lib}/**/*'] + %w[LICENSE.txt Rakefile README.md]

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_runtime_dependency 'sentry-rails', '~> 5.8'
  spec.add_runtime_dependency 'sentry-ruby', '~> 5.8'
  spec.add_runtime_dependency 'sentry-sidekiq', '~> 5.8'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
end
