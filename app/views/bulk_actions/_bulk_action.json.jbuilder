# frozen_string_literal: true

json.extract! bulk_action, :id, :created_at, :updated_at
json.url bulk_action_url(bulk_action, format: :json)
