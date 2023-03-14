# frozen_string_literal: true

module ForemanCement
  module SetSentryContext
    extend ActiveSupport::Concern

    included do
      before_action :set_sentry_context
    end

    private

    def set_sentry_context
      Sentry.set_user(
        id: User.current&.id,
        username: User.current&.login,
        email: User.current&.mail
      )
      Sentry.set_extras(
        params: params.to_unsafe_h,
        url: request.url,
        request_id: request.uuid
      )
    end
  end
end
