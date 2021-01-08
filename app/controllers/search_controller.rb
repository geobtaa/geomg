# frozen_string_literal: true

# SearchController
class SearchController < ApplicationController
  def index
    @facet_options = BlacklightApiFacets.new.facets
  end
end
