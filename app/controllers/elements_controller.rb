class ElementsController < ApplicationController
  before_action :set_element, only: %i[show edit update destroy]

  # GET /elements or /elements.json
  def index
    @pagy, @elements = pagy(Element.all.order(position: :asc), items: 100)
  end

  # GET /elements/1 or /elements/1.json
  def show
  end

  # GET /elements/new
  def new
    @element = Element.new
  end

  # GET /elements/1/edit
  def edit
  end

  # POST /elements or /elements.json
  def create
    @element = Element.new(element_params)

    respond_to do |format|
      if @element.save
        format.html { redirect_to element_url(@element), notice: "Element was successfully created." }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elements/1 or /elements/1.json
  def update
    respond_to do |format|
      if @element.update(element_params)
        format.html { redirect_to element_url(@element), notice: "Element was successfully updated." }
        format.json { render :show, status: :ok, location: @element }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elements/1 or /elements/1.json
  def destroy
    @element.destroy

    respond_to do |format|
      format.html { redirect_to elements_url, notice: "Element was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def sort
    Element.sort_elements(params[:id_list])
    render body: nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_element
    @element = Element.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def element_params
    params.require(:element).permit(:label, :solr_field, :field_definition, :field_type, :required, :repeatable, :formable, :placeholder_text, :data_entry_hint, :test_fixture_example, :controlled_vocabulary, :js_behaviors, :html_attributes, :display_only_on_persisted, :importable, :import_deliminated, :import_transformation_method, :exportable, :export_transformation_method, :indexable, :index_transformation_method, :validation_method, :position)
  end
end
