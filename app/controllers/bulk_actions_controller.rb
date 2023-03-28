# frozen_string_literal: true

# BulkActionsController
class BulkActionsController < ApplicationController
  before_action :set_bulk_action, only: %i[show edit update destroy run revert]

  # GET /bulk_actions
  # GET /bulk_actions.json
  def index
    @pagy, @bulk_actions = pagy(BulkAction.all.order(created_at: :desc), items: 20)
  end

  # GET /bulk_actions/1
  # GET /bulk_actions/1.json
  def show
    @pagy, @documents = pagy(@bulk_action.documents, items: 30)
    @bulk_action.check_run_state
  end

  # GET /bulk_actions/new
  def new
    @bulk_action = BulkAction.new(scope: params[:scope])
  end

  # GET /bulk_actions/1/edit
  def edit
  end

  # POST /bulk_actions
  # POST /bulk_actions.json
  def create
    @bulk_action = BulkAction.new(bulk_action_params)

    respond_to do |format|
      if @bulk_action.save
        format.html { redirect_to @bulk_action, notice: "Bulk action was successfully created." }
        format.json { render :show, status: :created, location: @bulk_action }
      else
        format.html { render :new }
        format.json { render json: @bulk_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulk_actions/1
  # PATCH/PUT /bulk_actions/1.json
  def update
    respond_to do |format|
      if @bulk_action.update(bulk_action_params)
        format.html { redirect_to @bulk_action, notice: "Bulk action was successfully updated." }
        format.json { render :show, status: :ok, location: @bulk_action }
      else
        format.html { render :edit }
        format.json { render json: @bulk_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulk_actions/1
  # DELETE /bulk_actions/1.json
  def destroy
    @bulk_action.destroy
    respond_to do |format|
      format.html { redirect_to bulk_actions_url, notice: "Bulk action was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def run
    @bulk_action.run!
    @bulk_action.state_machine.transition_to!(:queued)
    redirect_to bulk_action_url(@bulk_action), notice: "Bulk action is running. Check back soon for results."
  end

  def revert
    @bulk_action.revert!
    @bulk_action.state_machine.transition_to!(:queued)
    redirect_to bulk_action_url(@bulk_action), notice: "Revert bulk action is running. Check back soon for results."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bulk_action
    @bulk_action = BulkAction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bulk_action_params
    params.fetch(:bulk_action, {})
  end
end
