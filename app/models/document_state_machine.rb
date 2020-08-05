# frozen_string_literal: true

# Document Statesman
class DocumentStateMachine
  include Statesman::Machine

  state :Draft, initial: true
  state :Published
  state :Unpublished

  transition from: :Draft, to: %i[Draft Published Unpublished]
  transition from: :Published, to: %i[Draft Published Unpublished]
  transition from: :Unpublished, to: %i[Draft Published Unpublished]
end
