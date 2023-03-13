# frozen_string_literal: true

node :message do
  locals[:exception].message
end

node :sentry_id do
  Sentry.last_event_id
end
