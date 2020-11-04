# frozen_string_literal: true

# BulkActionRunJob
class BulkActionRunJob < ApplicationJob
  queue_as :default

  def perform(bulk_action)
    # Do something later
  end
end
