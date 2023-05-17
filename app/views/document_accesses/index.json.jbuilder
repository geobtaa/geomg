# frozen_string_literal: true

json.array! @document_accesses, partial: "document_accesses/document_access", as: :document_access
