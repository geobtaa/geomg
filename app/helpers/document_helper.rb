# frozen_string_literal: true

# DocumentHelper
module DocumentHelper
  def publication_state_badge(document)
    case document.publication_state
    when "draft"
      link_to("#document_publication_state") do
        tag.span("Draft", class: "badge badge-secondary")
      end
    when "published"
      link_to("#document_publication_state") do
        tag.span("Published", class: "badge badge-success")
      end
    when "unpublished"
      link_to("#document_publication_state") do
        tag.span("Unpublished", class: "badge badge-danger")
      end
    end
  end

  def localize_link(link)
    uri = URI.parse(link)
    "/documents?#{uri.query}"
  end

  def sort_link(link)
    link_to link["attributes"]["label"], localize_link(link["links"]["self"]), {class: "dropdown-item"}
  end

  def link_from_api(link)
    # Append facet - Full URI returned
    uri = URI.parse(link["links"]["self"])
    {action: "add", link: "/documents?#{uri.query}"}
  rescue
    # Remove facet - Only path and query returned
    uri = URI.parse(link["links"]["remove"])
    {action: "remove", link: "/documents?#{uri.query}"}
  end

  def previous_link(links)
    if links["prev"]
      link_to "Previous", localize_link(links["prev"]), {class: "btn btn-outline-primary btn-sm"}
    else
      link_to "Previous", "javascript:;", {class: "btn btn-outline-primary btn-sm disabled", "aria-disabled": true}
    end
  end

  def next_link(links)
    if links["next"]
      link_to "Next", localize_link(links["next"]), {class: "btn btn-outline-primary btn-sm"}
    else
      link_to "Next", "javascript:;", {class: "btn btn-outline-primary btn-sm disabled", "aria-disabled": true}
    end
  end

  def blacklight_link(document)
    "#{BLACKLIGHT_URL}/catalog/#{document.friendlier_id}"
  end
end
