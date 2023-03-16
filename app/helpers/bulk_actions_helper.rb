# frozen_string_literal: true

# BulkActionsHelper
module BulkActionsHelper
  def bulk_actions_collection
    attrs = Geomg.field_mappings.collect { |key, _value| key }
    attrs.prepend("Publication State")
  end
end
