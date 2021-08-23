# frozen_string_literal: true

# BlacklightApi
class BlacklightApi
  include HTTParty
  base_uri BLACKLIGHT_JSON_API

  def initialize(**args)
    defaults = {
      q: '*',
      page: 1,
      sort: 'score+desc%2C+dc_title_sort+asc',
      rows: 20
    }

    @options = defaults.merge(**args)
    append_facets(@options[:f], @options)
    @options.compact!
  end

  def fetch
    @fetch ||= self.class.get('/', query: @options)
  end

  def results
    fetch['data']
  end

  def facets
    fetch['included']&.filter_map { |s| s if s['type'] == 'facet' }
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

  def load_all
    results.map { |result| Document.find_by(friendlier_id: result['id']) }
  end

  def pluck(field)
    load_all.pluck(field.to_sym)
  end

  private

  def append_facets(facets, options)
    options.merge!({ f: facets }) if facets.present?
    options
  end
end
