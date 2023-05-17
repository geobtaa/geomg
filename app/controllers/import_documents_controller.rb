# frozen_string_literal: true

# ImportDocumentsController
class ImportDocumentsController < ApplicationController
  before_action :set_import_document, only: %i[show]

  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import_document
    @import_document = ImportDocument.find(params[:id])
  end
end
