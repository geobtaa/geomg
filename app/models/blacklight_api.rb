class BlacklightApi
  include HTTParty
  base_uri BLACKLIGHT_JSON_API

  attr_accessor :fetch

  def initialize(query='*', facets=[], page=1)
    @options = { q: query, page: page }
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
    fetch['included']
  end

  def meta
    fetch['meta']
  end

  private

  def append_facets(facets, options)
    options.merge!({f: facets}) if facets.present?
    options
  end
end
