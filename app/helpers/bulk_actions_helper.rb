# frozen_string_literal: true

# BulkActionsHelper
module BulkActionsHelper
  def bulk_actions_collection
    attrs = GEOMG.field_mappings_btaa.collect { |key, _value| key }
    attrs.prepend('Publication State')
  end
end
