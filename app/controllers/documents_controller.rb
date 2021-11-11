# frozen_string_literal: true

# DocumentsController
class DocumentsController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true
  before_action :set_document,
                only: %i[show edit update destroy]

  # GET /documents
  # GET /documents.json
  def index
    query_params = { q: params['q'], f: params['f'], page: params['page'], rows: params['rows'] || 20 }

    @documents = BlacklightApi.new(**query_params)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @documents.results.to_json }

      # JSON - BTAA Aardvark
      format.json_btaa_aardvark do
        ExportJsonJob.perform_later(current_user, query_params.merge!({ format: 'json_btaa_aardvark' }), ExportJsonService)
        head :no_content
      end

      # JSON - GBL Aardvark
      format.json_aardvark do
        ExportJsonJob.perform_later(current_user, query_params.merge!({ format: 'json_aardvark' }), ExportJsonService)
        head :no_content
      end

      # JSON - GBL v1
      format.json_gbl_v1 do
        ExportJsonJob.perform_later(current_user, query_params.merge!({ format: 'json_gbl_v1' }), ExportJsonService)
        head :no_content
      end

      # CSV - B1G
      format.csv do
        ExportJob.perform_later(current_user, query_params, ExportCsvService)
        head :no_content
      end
    end
  end

  # Fetch documents from array of friendlier_ids
  def fetch
    @documents = Document.where(friendlier_id: params['ids'])

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @documents.to_json }

      # JSON - BTAA Aardvark
      format.json_btaa_aardvark do
        ExportJsonJob.perform_later(current_user, { ids: @documents.pluck(:friendlier_id), format: 'json_btaa_aardvark' },
                                    ExportJsonService)
        head :no_content
      end

      # JSON - GBL Aardvark
      format.json_aardvark do
        ExportJsonJob.perform_later(current_user, { ids: @documents.pluck(:friendlier_id), format: 'json_aardvark' }, ExportJsonService)
        head :no_content
      end

      # JSON - GBL v1
      format.json_gbl_v1 do
        ExportJsonJob.perform_later(current_user, { ids: @documents.pluck(:friendlier_id), format: 'json_gbl_v1' }, ExportJsonService)
        head :no_content
      end

      # CSV - B1G
      format.csv do
        ExportJob.perform_later(current_user, { ids: @documents.pluck(:friendlier_id), format: 'csv' }, ExportCsvService)
        head :no_content
      end
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
    @document.friendlier_id = @document.send(GEOMG.FIELDS.LAYER_SLUG)
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
    respond_to do |format|
      format.html { redirect_to edit_document_url(@document) }
      format.json { render json: @document.to_json } # App-style JSON
      format.json_aardvark
      format.json_btaa_aardvark
      format.json_gbl_v1
      # B1G CSV
      format.csv { send_data collect_csv([@document]), filename: "documents-#{Time.zone.today}.csv" }

      # @TODO:
      # geoblacklight_version: 1.0 (strict)
      # geoblacklight_version: 1.0 + B1G customizations
      # geoblacklight_version: 2.0 (strict)
      # geoblacklight_version: 2.0 + B1G customizations
    end
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
  def permittable_params
    %i[title publication_state layer_geom_type_s dct_references_s q f page sort rows]
  end

  def document_params
    Kithe::Parameters.new(params).require(:document).permit_attr_json(Document).permit(permittable_params)
  end

  def collect_csv(documents)
    CSV.generate(headers: true) do |csv|
      csv << Geomg.field_mappings_btaa.map { |k, _v| k.to_s }
      if documents.instance_of?(BlacklightApi)
        documents.load_all.map do |doc|
          csv << doc.to_csv if doc.present?
        end
      else
        documents.each do |doc|
          csv << doc.to_csv
        end
      end
    end
  end
end
