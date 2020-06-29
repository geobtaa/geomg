# frozen_string_literal: true

# DocumentsController
class DocumentsController < ApplicationController
  before_action :set_document,
                only: %i[show edit update destroy]

  # GET /documents
  # GET /documents.json

  def index
    unsafe_params = params.to_unsafe_h

    @documents = BlacklightApi.new(
      unsafe_params['q'],
      unsafe_params['f'],
      unsafe_params['page'],
      unsafe_params['sort'],
      unsafe_params['rows'] || 20
    )

    respond_to do |format|
      format.html { render :index }
      # @TODO: Should be GBL JSON
      format.json { render json: @documents.results.to_json }
      # B1G CSV
      format.csv  { send_data collect_csv(@documents), filename: "documents-#{Time.zone.today}.csv" }
    end
  end

  # GET /documents/new
  def new
    @document = Document.new
    render :edit
  end

  # GET /documents/1/edit
  def edit; end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.friendlier_id = @document.dc_identifier_s

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to edit_document_path(@document), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document '#{@document.title}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show
    redirect_to edit_document_url(@document)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.includes(:leaf_representative).find_by!(friendlier_id: params[:id])
  end

  # only allow whitelisted params through (TODO, we're allowing all document params!)
  # Plus sanitization or any other mutation.
  #
  # This could be done in a form object or otherwise abstracted, but this is good
  # enough for now.
  def document_params
    Kithe::Parameters.new(params).require(:document).permit_attr_json(Document).permit(
      :title,
      :layer_slug_s,
      :layer_geom_type_s,
      :dct_references_s
    )
  end

  def collect_csv(documents)
    CSV.generate(headers: true) do |csv|
      csv << Geomg.field_mappings_btaa.map { |k, _v| k.to_s }
      documents.load_all.map do |doc|
        csv << doc.to_csv
      end
    end
  end
end
