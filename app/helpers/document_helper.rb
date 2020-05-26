module DocumentHelper
  def link_from_api(link)
    begin
      # Append facet - Full URI returned
      uri = URI::parse(link['links']['self'])
      "/documents?#{uri.query}"
    rescue
      # Remove facet - Only path and query returned
      uri = link['links']['remove']
      "/documents?#{uri.split('/catalog.json?').last}"
    end
  end
end
