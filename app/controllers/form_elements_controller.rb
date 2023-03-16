class FormElementsController < ApplicationController
  before_action :set_form_element, only: %i[show edit update destroy]

  # GET /form_elements or /form_elements.json
  def index
    @form_elements = FormElement.all
  end

  # GET /form_elements/1 or /form_elements/1.json
  def show
  end

  # GET /form_elements/new
  def new
    @form_element = FormElement.new
  end

  # GET /form_elements/1/edit
  def edit
  end

  # POST /form_elements or /form_elements.json
  def create
    @form_element = FormElement.new(form_element_params)

    respond_to do |format|
      if @form_element.save
        format.html { redirect_to form_elements_path, notice: "Form element was successfully created." }
        format.json { render :show, status: :created, location: @form_element }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_elements/1 or /form_elements/1.json
  def update
    respond_to do |format|
      if @form_element.update(form_element_params)
        format.html { redirect_to form_element_url(@form_element), notice: "Form element was successfully updated." }
        format.json { render :show, status: :ok, location: @form_element }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_elements/1 or /form_elements/1.json
  def destroy
    @form_element.destroy

    respond_to do |format|
      format.html { redirect_to form_elements_url, notice: "Form element was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def sort
    FormElement.sort_elements(params[:id_list])
    render body: nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form_element
    @form_element = FormElement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_element_params
    params.require(:form_element).permit(:type, :label, :element_solr_field)
  end
end
