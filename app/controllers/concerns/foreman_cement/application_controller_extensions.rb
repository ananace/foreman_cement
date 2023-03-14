# frozen_string_literal: true

module ForemanCement
  module ApplicationControllerExtensions
    extend ActiveSupport::Concern

    module Overrides
      def generic_exception(exception)
        return sti_clean_up(exception.cause) \
          if User.current&.admin? && exception.try(:cause).is_a?(ActiveRecord::SubclassNotFound)

        ex_message = exception.message
        Foreman::Logging.exception("[Reported to Sentry] #{ex_message}", exception)

        render template: 'foreman_cement/500',
               layout: !request.xhr?,
               status: :internal_server_error,
               locals: {
                 exception: exception,
                 sentry_id: Sentry.last_event_id
               }
      end
    end

    included do
      prepend Overrides
      include ForemanCement::SetSentryContext
    end
  end
end
