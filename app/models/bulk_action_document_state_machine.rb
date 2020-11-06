# frozen_string_literal: true

# BulkActionDocument Statesman
class BulkActionDocumentStateMachine
  include Statesman::Machine

  state :created, initial: true
  state :queued
  state :success
  state :failed

  transition from: :created, to: [:queued]
  transition from: :queued, to: %i[queued success failed]
  transition from: :success, to: %i[queued success failed]
  transition from: :failed, to: %i[queued success failed]
end
