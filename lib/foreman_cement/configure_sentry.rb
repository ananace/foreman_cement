# frozen_string_literal: true

require 'sentry-ruby'
require 'sentry-rails'
require 'sentry-sidekiq'

Sentry.init do |config|
  config.logger = Foreman::Logging.logger('foreman_cement')
  config.dsn = SETTINGS.with_indifferent_access['sentry_dsn']
  config.release = SETTINGS[:version].version
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  if SETTINGS.with_indifferent_access['sentry_trace']
    config.traces_sample_rate = if SETTINGS.with_indifferent_access['sentry_trace'].is_a?(Hash)
                                  SETTINGS.with_indifferent_access.dig('sentry_trace', 'rate') || 0.2
                                else
                                  0.2
                                end
  end

  filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  config.before_send = lambda do |event, _hint|
    filter.filter(event.to_hash)
  end
end
