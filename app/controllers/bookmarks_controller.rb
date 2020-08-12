# frozen_string_literal: true

# BookmarksController
class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @pagy, @bookmarks = pagy(current_user.bookmarks)

    respond_to do |format|
      format.html { render :index }
      # B1G CSV
      format.csv  { send_data collect_csv(current_user.bookmarks), filename: "documents-#{Time.zone.today}.csv" }
    end
  end

  def collect_csv(bookmarks)
    CSV.generate(headers: true) do |csv|
      csv << Geomg.field_mappings_btaa.map { |k, _v| k.to_s }
      bookmarks.map do |bookmark|
        csv << bookmark.document.to_csv
      end
    end
  end
end
