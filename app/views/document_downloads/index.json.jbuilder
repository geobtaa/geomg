# frozen_string_literal: true

json.array! @document_downloads, partial: "document_downloads/document_download", as: :document_download
