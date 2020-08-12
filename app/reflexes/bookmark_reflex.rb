# frozen_string_literal: true

# BookmarkReflex
class BookmarkReflex < ApplicationReflex
  delegate :current_user, to: :connection

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def create
    document = Document.find_by(friendlier_id: element.dataset[:friendlier_id])
    Bookmark.find_or_create_by(user: current_user, document: document)
  end

  def destroy
    document = Document.find_by(friendlier_id: element.dataset[:friendlier_id])
    Bookmark.find_by(user: current_user, document: document)&.destroy
  end
end
