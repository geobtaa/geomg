# frozen_string_literal: true

module DocumentHelper
  def localize_link(link)
    uri = URI.parse(link)
    "/documents?#{uri.query}"
  end

  def sort_link(link)
    link_to link['attributes']['label'], localize_link(link['links']['self']), { class: 'dropdown-item' }
  end

  def link_from_api(link)
    # Append facet - Full URI returned
    uri = URI.parse(link['links']['self'])
    { action: 'add', link: "/documents?#{uri.query}" }
  rescue StandardError
    # Remove facet - Only path and query returned
    uri = link['links']['remove']
    { action: 'remove', link: "/documents?#{uri.split('/catalog.json?').last}" }
  end

  def previous_link(links)
    if links['prev']
      link_to 'Previous', localize_link(links['prev']), { class: 'btn btn-outline-primary btn-sm' }
    else
      link_to 'Previous', 'javascript:;', { class: 'btn btn-outline-primary btn-sm disabled', 'aria-disabled': true }
    end
  end

  def next_link(links)
    if links['next']
      link_to 'Next', localize_link(links['next']), { class: 'btn btn-outline-primary btn-sm' }
    else
      link_to 'Next', 'javascript:;', { class: 'btn btn-outline-primary btn-sm disabled', 'aria-disabled': true }
    end
  end

  def blacklight_link(document)
    "#{BLACKLIGHT_URL}/catalog/#{document.friendlier_id}"
  end
end
