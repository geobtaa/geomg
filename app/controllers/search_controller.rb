class SearchController < ApplicationController
  def index
    @facet_options = BlacklightApiFacets.new.facets
  end
end
