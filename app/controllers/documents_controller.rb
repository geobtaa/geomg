class DocumentsController < ApplicationController
  before_action :set_document,
    only: [:show, :edit, :update, :destroy, :publish, :unpublish]

  # GET /documents
  # GET /documents.json

  def index
    unsafe_params = params.to_unsafe_h
    @documents = BlacklightApi.new(
      unsafe_params['q'],
      unsafe_params['f'],
      unsafe_params['page'],
      unsafe_params['sort']
    )
  end

  # GET /documents/new
  def new
    @document = Document.new
    render :edit
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

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
        format.html { redirect_to edit_document_path(@document), notice: 'document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1/publish
  #
  # publishes document AND all of it's children (multi-level).
  #
  # fetches all children so rails callbacks will be called, but uses postgres
  # recursive CTE so it'll be efficient-ish.
  def publish
    authorize! :publish, @document

    @document.class.transaction do
      @document.update!(published: true)
      @document.all_descendent_members.find_each do |member|
        member.update!(published: true)
      end
    end

    redirect_to admin_document_url(@document)
  rescue ActiveRecord::RecordInvalid => e
    # probably because missing a field required for a document to be published, but
    # could apply to a CHILD document, not just the parent you actually may have clicked 'publish'
    # on.
    #
    # The document we're going to report and redirect to is just the FIRST one we encountered
    # with an error, there could be more.
    @document = e.record
    @document.published = true
    flash.now[:error] = "Can't publish document: #{@document.title}: #{e.message}"
    render :edit
  end

  # PUT /documents/1/unpublish
  #
  # unpublishes document AND all of it's children (multi-level) using a pg recursive CTE
  #
  # fetches all children so rails callbacks will be called, but uses postgres
  # recursive CTE so it'll be efficient-ish.
  def unpublish
    authorize! :publish, @document

    @document.class.transaction do
      @document.update!(published: false)
      @document.all_descendent_members.find_each do |member|
        member.update!(published: false)
      end
    end

    redirect_to admin_document_url(@document)
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: "document '#{@document.title}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def show
    redirect_to edit_document_url(@document)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.includes(:leaf_representative).find_by_friendlier_id!(params[:id])
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
end
