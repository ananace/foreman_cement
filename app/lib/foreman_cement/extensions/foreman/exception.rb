# frozen_string_literal: true

module ForemanCement
  module Extensions
    module Foreman
      module Exception
        extend ActiveSupport::Concern

        def sentry_context
          {
            extra: {
              erf_code: code
            }
          }
        end
      end
    end
  end
end
