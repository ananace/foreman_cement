# frozen_string_literal: true

module ForemanCement
  class Engine < ::Rails::Engine
    engine_name 'foreman_cement'

    config.autoload_paths += Dir["#{config.root}/app/lib"]
    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]

    initializer 'foreman_cement.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_cement do
          requires_foreman '>= 3.12'

          logger :sentry, enabled: true
        end
      end
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      require 'foreman_cement/configure_sentry' if SETTINGS.with_indifferent_access['sentry_dsn']

      ::Foreman::Exception.include ForemanCement::Extensions::Foreman::Exception
      ::Foreman::LoggingImpl.include ForemanCement::Extensions::Foreman::Logging
      ::ApplicationController.include ForemanCement::ApplicationControllerExtensions
      ::Api::BaseController.include ForemanCement::Api::BaseControllerExtensions
    rescue StandardError => e
      Sentry.capture_exception(e)
      Rails.logger.warn "ForemanCement: skipping engine hook (#{e})"
    end
  end
end
