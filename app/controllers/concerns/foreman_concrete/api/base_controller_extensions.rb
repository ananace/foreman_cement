# frozen_string_literal: true

module ForemanCement
  module Api
    module BaseControllerExtensions
      extend ActiveSupport::Concern

      included do
        include ForemanCement::SetSentryContext

        # Prepend our view path so we can display
        # the last sentry event id in the error message
        before_action :prepend_cement_view_path
      end

      def prepend_cement_view_path
        engine_root = ForemanCement::Engine.root.to_s
        prepend_view_path File.join(engine_root, 'app/views')
      end
    end
  end
end
