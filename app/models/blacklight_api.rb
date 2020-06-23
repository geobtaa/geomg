# frozen_string_literal: true

# BlacklightApi
class BlacklightApi
  include HTTParty
  base_uri BLACKLIGHT_JSON_API

  attr_accessor :fetch

  def initialize(query = '*', facets = [], page = 1, sort = 'score+desc%2C+dc_title_sort+asc')
    @options = { q: query, page: page, sort: sort }
    append_facets(facets, @options)

    @options
  end

  def fetch
    @fetch ||= self.class.get('/', query: @options)
  end

  def results
    fetch['data']
  end

  def facets
    fetch['included'].filter_map { |s| s if s['type'] == 'facet' }
  end

  def sorts
    fetch['included'].filter_map { |s| s if s['type'] == 'sort' }
  end

  def meta
    fetch['meta']
  end

  def links
    fetch['links']
  end

  private

  def append_facets(facets, options)
    options.merge!({ f: facets }) if facets.present?
    options
  end
end
