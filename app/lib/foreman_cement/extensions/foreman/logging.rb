# frozen_string_literal: true

module ForemanCement
  module Extensions
    module Foreman
      module Logging
        extend ActiveSupport::Concern

        module Overrides
          def exception(context_message, exception, options = {})
            super

            sentry_context = {
              extra: {
                context_message: context_message
              },
              level: options[:level] || :warn,
            }
            Sentry.capture_exception(exception, **sentry_context)
          end
        end

        included do
          prepend Overrides
        end
      end
    end
  end
end
