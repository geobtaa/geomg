class MappingsController < ApplicationController
  before_action :set_mapping, only: [:show, :edit, :update, :destroy]

  # GET /import/:id/mappings
  # GET /import/:id/mappings.json
  def index
    @import = Import.find(params[:import_id])
    @mappings = Mapping.where(import_id: @import)

    # Build mappings unless we already have
    @import.mappings.build unless @import.mappings.present?
  end

  # GET /mappings/1
  # GET /mappings/1.json
  def show
  end

  # GET /mappings/new
  def new
    @mapping = Mapping.new
  end

  # GET /mappings/1/edit
  def edit
  end

  # POST /mappings
  # POST /mappings.json
  def create
    @mapping = Mapping.new(mapping_params)

    respond_to do |format|
      if @mapping.save
        format.html { redirect_to @mapping, notice: 'Mapping was successfully created.' }
        format.json { render :show, status: :created, location: @mapping }
      else
        format.html { render :new }
        format.json { render json: @mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mappings/1
  # PATCH/PUT /mappings/1.json
  def update
    respond_to do |format|
      if @mapping.update(mapping_params)
        format.html { redirect_to @mapping, notice: 'Mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @mapping }
      else
        format.html { render :edit }
        format.json { render json: @mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mappings/1
  # DELETE /mappings/1.json
  def destroy
    @mapping.destroy
    respond_to do |format|
      format.html { redirect_to mappings_url, notice: 'Mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mapping
      @mapping = Mapping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mapping_params
      params.require(:mapping).permit(
        :source_header,
        :destination_field,
        :delimited,
        :transformation_method,
        :import_id
      )
    end
end
