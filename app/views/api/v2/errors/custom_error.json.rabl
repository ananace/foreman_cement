# frozen_string_literal: true

node :message do
  locals[:message]
end

node :sentry_id do
  Sentry.last_event_id
end
