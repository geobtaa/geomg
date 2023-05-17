# frozen_string_literal: true

# DocumentDownloadsController
class DocumentDownloadsController < ApplicationController
  before_action :set_document
  before_action :set_document_download, only: %i[show edit update destroy]

  # GET /document_downloads or /document_downloads.json
  def index
    @document_downloads = DocumentDownload.all
    if params[:document_id]
      @document_downloads = DocumentDownload.where(friendlier_id: @document.friendlier_id).order(position: :asc)
    else
      @pagy, @document_downloads = pagy(DocumentDownload.all.order(friendlier_id: :asc, updated_at: :desc), items: 20)
    end
  end

  # GET /document_downloads/1 or /document_downloads/1.json
  def show
  end

  # GET /document_downloads/new
  def new
    @document_download = DocumentDownload.new
  end

  # GET /document_downloads/1/edit
  def edit
  end

  # POST /document_downloads or /document_downloads.json
  def create
    @document_download = DocumentDownload.new(document_download_params)

    logger.debug("DD Params: #{DocumentDownload.new(document_download_params).inspect}")
    logger.debug("Document DOWNLOAD: #{@document_download.inspect}")

    respond_to do |format|
      if @document_download.save
        format.html do
          redirect_to document_document_downloads_path(@document_download.document), notice: "Document download was successfully created."
        end
        format.json { render :show, status: :created, location: @document_download }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document_download.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_downloads/1 or /document_downloads/1.json
  def update
    respond_to do |format|
      if @document_download.update(document_download_params)
        format.html do
          redirect_to document_document_downloads_path(@document_download.document), notice: "Document download was successfully updated."
        end
        format.json { render :show, status: :ok, location: @document_download }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document_download.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_downloads/1 or /document_downloads/1.json
  def destroy
    @document_download.destroy

    respond_to do |format|
      format.html { redirect_to document_downloads_url, notice: "Document download was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_all
    logger.debug("Destroy Downloads")
    return unless params.dig(:document_download, :downloads, :file)

    respond_to do |format|
      if DocumentDownload.destroy_all(params.dig(:document_download, :downloads, :file))
        format.html { redirect_to document_downloads_path, notice: "Download Links were created destroyed." }
      else
        format.html { redirect_to document_downloads_path, notice: "Download Links could not be destroyed." }
      end
    rescue => e
      format.html { redirect_to document_downloads_path, notice: "Download Links could not be destroyed. #{e}" }
    end
  end

  # GET   /documents/#id/downloads/import
  # POST  /documents/#id/downloads/import
  def import
    logger.debug("Import Downloads")
    return unless params.dig(:document_download, :downloads, :file)

    respond_to do |format|
      if DocumentDownload.import(params.dig(:document_download, :downloads, :file))
        format.html { redirect_to document_downloads_path, notice: "Download Links were created successfully." }
      else
        format.html { redirect_to document_downloads_path, notice: "Download Links could not be created." }
      end
    rescue => e
      format.html { redirect_to document_downloads_path, notice: "Download Links could not be created. #{e}" }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    return unless params[:document_id] # If not nested

    @document = Document.includes(:leaf_representative).find_by!(friendlier_id: params[:document_id])
  end

  def set_document_download
    @document_download = DocumentDownload.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_download_params
    params.require(:document_download).permit(:friendlier_id, :label, :value, :position)
  end
end
