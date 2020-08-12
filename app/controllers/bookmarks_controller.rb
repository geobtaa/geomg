# frozen_string_literal: true

# BookmarksController
class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @pagy, @bookmarks = pagy(current_user.bookmarks)
  end
end
