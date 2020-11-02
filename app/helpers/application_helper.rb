# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  include Pagy::Frontend

  # qa (questioning_authoriry) gem oddly gives us no route helpers, so
  # let's make one ourselves, for it's current mount point, we can change
  # it if needed but at least it's DRY.
  def qa_search_vocab_path(vocab, subauthority = nil)
    path = "/authorities/search/#{CGI.escape vocab}"

    path += "/#{CGI.escape subauthority}" if subauthority

    path
  end

  def flash_class(level)
    alerts = {
      'notice' => 'alert alert-info',
      'success' => 'alert alert-success',
      'error' => 'alert alert-error',
      'alert' => 'alert alert-error'
    }
    alerts[level]
  end
end
