# frozen_string_literal: true

json.extract! document_download, :id, :friendlier_id, :label, :value, :position, :created_at, :updated_at
json.url document_download_url(document_download, format: :json)
