class ImportTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  validates :to_state, inclusion: { in: ImportStateMachine.states }

  belongs_to :import, inverse_of: :import_transitions
end
