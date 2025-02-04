# frozen_string_literal: true

require 'sentry-ruby'
require 'sentry-rails'
require 'sentry-sidekiq'

# rubocop:disable Metrics/BlockLength
Sentry.init do |config|
  config.logger = if Rails.const_defined? 'Server'
                    Foreman::Logging.logger('foreman_cement/sentry')
                  else
                    Foreman::Logging.logger('background')
                  end
  config.dsn = SETTINGS.with_indifferent_access['sentry_dsn']
  config.release = SETTINGS[:version].version
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  if SETTINGS.with_indifferent_access['sentry_trace']
    main_rate =
      if SETTINGS.with_indifferent_access['sentry_trace'].is_a?(Hash)
        SETTINGS.with_indifferent_access.dig('sentry_trace', 'rate') || 0.5
      else
        0.5
      end

    config.traces_sampler = lambda do |ctx|
      next ctx[:parent_sampled] if ctx[:parent_sampled]

      tctx = ctx[:transaction_context]
      case tctx[:op]
      when /http/
        case tctx[:name]
        when /api/
          main_rate / 2
        when /hosts/
          main_rate
        else
          main_rate / 10
        end
      when /sidekiq/
        main_rate / 100
      else
        false
      end
    end
  end

  ## FIXME: Filters out required Sentry data if enabled
  # filter = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  # config.before_send = lambda do |event, _hint|
  #   filter.filter(event.to_hash)
  # end
end
# rubocop:enable Metrics/BlockLength
