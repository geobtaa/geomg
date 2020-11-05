# frozen_string_literal: true

# BulkAction Statesman
class BulkActionStateMachine
  include Statesman::Machine

  state :created, initial: true
  state :queued
  state :complete
  state :failed

  transition from: :created,  to: [:queued]
  transition from: :queued, to: %i[created queued complete failed]
end
