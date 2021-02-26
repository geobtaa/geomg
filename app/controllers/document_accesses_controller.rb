# frozen_string_literal: true

# DocumentAccessesController
class DocumentAccessesController < ApplicationController
  before_action :set_document
  before_action :set_document_access, only: %i[show edit update destroy]

  # GET /documents/#id/access
  # GET /documents/#id/access.json
  def index
    @document_accesses = DocumentAccess.where(friendlier_id: @document.friendlier_id).order(institution_code: :asc)
  end

  # GET /document_accesses/1
  # GET /document_accesses/1.json
  def show; end

  # GET /document_accesses/new
  def new
    @document_access = DocumentAccess.new
  end

  # GET /document_accesses/1/edit
  def edit; end

  # POST /document_accesses
  # POST /document_accesses.json
  def create
    @document_access = DocumentAccess.new(document_access_params)
    logger.debug("DA Params: #{DocumentAccess.new(document_access_params).inspect}")
    logger.debug("Document ACCESS: #{@document_access.inspect}")

    respond_to do |format|
      if @document_access.save
        format.html { redirect_to document_document_accesses_path(@document), notice: 'Document access was successfully created.' }
        format.json { render :show, status: :created, location: @document_access }
      else
        format.html { render :new }
        format.json { render json: @document_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_accesses/1
  # PATCH/PUT /document_accesses/1.json
  def update
    respond_to do |format|
      if @document_access.update(document_access_params)
        format.html { redirect_to document_document_accesses_path(@document), notice: 'Document access was successfully updated.' }
        format.json { render :show, status: :ok, location: @document_access }
      else
        format.html { render :edit }
        format.json { render json: @document_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_accesses/1
  # DELETE /document_accesses/1.json
  def destroy
    @document_access.destroy
    respond_to do |format|
      format.html { redirect_to document_document_accesses_path(@document), notice: 'Document access was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET   /documents/#id/access/import
  # POST  /documents/#id/access/import
  def import
    return unless params.dig(:document, :assets, :file)

    respond_to do |format|
      DocumentAccess.import(@document, params.dig(:document, :assets, :file))
      redirect_to document_document_accesses_path(@document), notice: 'Document access links were created successfully.'
    rescue StandardError => e
      format.html { redirect_to document_document_accesses_path(@document), notice: "Access URLs could not be created. #{e}" }
      format.json { render json: @document.errors, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.includes(:leaf_representative).find_by!(friendlier_id: params[:document_id])
  end

  def set_document_access
    @document_access = DocumentAccess.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_access_params
    params.require(:document_access).permit(:friendlier_id, :institution_code, :access_url)
  end
end
