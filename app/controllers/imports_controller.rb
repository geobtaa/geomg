# frozen_string_literal: true

# ImportsController
class ImportsController < ApplicationController
  before_action :set_import, only: %i[show edit update destroy run]

  # GET /imports
  # GET /imports.json
  def index
    @pagy, @imports = pagy(Import.all.order("created_at DESC"), items: 20)
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
    @pagy_failed, @import_failed_documents = pagy(@import.import_documents.not_in_state(:success), items: 100)
    @pagy_success, @import_success_documents = pagy(@import.import_documents.in_state(:success), items: 100)
  end

  # GET /imports/new
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit
  end

  # POST /imports
  # POST /imports.json
  def create
    @import = Import.new(import_params)

    respond_to do |format|
      if @import.save
        format.html { redirect_to import_mappings_path(@import), notice: "Import was successful. Please set your import mapping rules." }
        format.json { render :show, status: :created, location: @import }
      else
        format.html { render :new }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imports/1
  # PATCH/PUT /imports/1.json
  def update
    respond_to do |format|
      if @import.update(import_params)
        format.html { redirect_to import_path(@import), notice: "Import was successfully updated." }
        format.json { render :show, status: :ok, location: @import }
      else
        format.html { render :edit }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    @import.destroy
    respond_to do |format|
      format.html { redirect_to imports_url, notice: "Import was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def run
    @import.run!
    redirect_to import_url(@import), notice: "Import is running. Check back soon for results."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import
    @import = Import.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def permittable_params
    %i[type name filename source description row_count encoding content_type extension validity validation_result csv_file run]
  end

  def import_params
    # Handle STI key
    key = (params.keys & %w[import import_btaa import_btaa_aardvark import_gblv1])[0]
    params.require(key).permit(
      permittable_params,
      mappings_attributes: %i[
        id
        source_header
        destination_field
        delimited
        transformation_method
        import_id
      ],
      headers: []
    )
  end
end
