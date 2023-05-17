# frozen_string_literal: true

# BookmarksController
class BookmarksController < ApplicationController
  before_action :set_document,
    only: %i[create destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @pagy, @bookmarks = pagy(current_user.bookmarks)

    respond_to do |format|
      format.html { render :index }
      # B1G CSV
      format.csv { send_data collect_csv(current_user.bookmarks), filename: "documents-#{Time.zone.today}.csv" }
    end
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.find_or_create_by(user: current_user, document: @document)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: "Bookmark was successfully created." }
        format.js
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    Bookmark.destroy_by(user: current_user, document: @document)

    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: "Bookmark was successfully destroyed." }
      format.js
    end
  end

  private

  def set_document
    @document = Document.find_by(friendlier_id: params["document"])
  end

  # Only allow a list of trusted parameters through.
  def bookmark_params
    params.fetch(:bookmark, {})
  end

  def collect_csv(bookmarks)
    CSV.generate(headers: true) do |csv|
      csv << Geomg::Schema.instance.importable_fields.map { |k, _v| k.to_s }
      bookmarks.map do |bookmark|
        csv << bookmark.document.to_csv
      end
    end
  end
end
