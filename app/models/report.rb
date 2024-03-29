# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'

# Report
module Report
  def query(params)
    Faraday.default_adapter = :net_http
    conn = Faraday.new(
      url: ENV.fetch('SOLR_URL', nil).to_s,
      headers: { 'Content-Type' => 'application/json' }
    )

    Rails.logger.debug { "Query: #{params}" }
    conn.post 'select', params.to_json
  end

  def num_found; end
end

# Report::Overview
module Report
  # Report::Overview
  class Overview
    include Report

    attr_accessor :q, :date_start, :date_end, :sort, :page, :search_field

    DEFAULTS = {
      q: '',
      page: '1',
      sort: 'relevance',
      compare: false
    }.with_indifferent_access.freeze

    def initialize(options = {}, compare: false)
      options = DEFAULTS.merge(options)

      # Set attrs
      @q = options[:q]
      @page = options[:page]
      @run_compare = compare

      date_params(options)
      Rails.logger.debug { "Compare: #{@run_compare}" }
      Rails.logger.debug { "Dates: #{@date_start} TO #{@date_end}" }

      data(options)
    end

    def data(params = {})
      return @data if @data

      Rails.logger.debug { 'Querying Solr' }
      search_query = build_search_query(params)
      Rails.logger.debug { JSON.pretty_generate(search_query) }
      @data = JSON.parse(query(search_query).body)
    end

    def num_found
      @data['response']['numFound']
    end

    def first_date
      if @data['facets'] && @data['facets']['doc_counts']
        @data['facets']['doc_counts']['buckets'].first['val']
      else
        Chronic.parse('One year ago')
      end
    end

    def data_series
      if @data['facets'] && @data['facets']['doc_counts']
        @data['facets']['doc_counts']['buckets'].map { |k, _v| k['count'] }
      else
        []
      end
    end

    def date_str_series
      if @data['facets'] && @data['facets']['doc_counts']
        @data['facets']['doc_counts']['buckets'].map { |k, _v| Date.parse(k['val']).strftime('%F') }
      else
        []
      end
    end

    def facets
      if @data['facet_counts'] && @data['facet_counts']['facet_fields']
        @data['facet_counts']['facet_fields']
      else
        []
      end
    end

    private

    def build_search_query(params = {})
      # We're building a boolean query
      search_query = {
        query: {
          bool: {
            must: [],
            must_not: [],
            should: []
          }
        }
      }.with_indifferent_access

      # apply_query!
      search_query[:query][:bool][:must] << apply_query!
      Rails.logger.debug { "Apply Query: #{search_query.inspect}" }

      # apply_includes!
      apply_includes!(search_query, params)
      Rails.logger.debug { "Apply Includes: #{search_query.inspect}" }

      # @TODO - Facets
      # WARNING: requires schema change, to copy date created into a date range field
      # apply_aggregations!(search_query, params)
      # search_query[:facet] = {
      #   "doc_counts": {
      #     "type": "range",
      #     "field": "date_created_dtsi",
      #     "start": "NOW/DAY-365DAYS",
      #     "end":  "NOW",
      #     "gap": "+1MONTH"
      #   }
      # }

      search_query
    end

    def apply_query!
      if @q.blank?
        'text:*'
      else
        "text:#{q}"
      end
    end

    def apply_includes!(search_query, params)
      must_includes = []
      should_includes = []

      # Add each include
      params[:f]&.each do |facet_field|
        shoulds = []
        params[:f][facet_field[0]].each do |fltr|
          shoulds << "#{facet_field[0]}:\"#{fltr}\""
        end

        should_includes << {
          bool: {
            should: shoulds,
            minimum_should_match: 1
          }
        }
      end

      # Build compare dates
      Rails.logger.debug { "Params: #{params}" }
      Rails.logger.debug { "COMPARE: #{@run_compare}" }
      if @run_compare
        ca = {}
        ca = params['created_at']['compare'] if params['created_at'] && params['created_at']['compare']
        ca[:start] ||= 28.days.ago - 28.days
        ca[:end] ||= 28.days.ago
        @date_start = parse_date_if_needed(ca[:start])
        @date_end = parse_date_if_needed(ca[:end])
      end

      must_includes << "date_created_drsim:[#{@date_start} TO #{@date_end}]"

      must_includes     = must_includes.compact_blank
      should_includes   = should_includes.compact_blank

      search_query[:query][:bool][:must].concat(must_includes.concat(should_includes))
    end

    def facet_constraints(_facet_params)
      []
      # return [] unless facet_params
      # FACET_FIELDS.select { |facet| facet_params[facet] }
    end

    def parse_date_if_needed(time_or_string)
      return time_or_string unless time_or_string.is_a? String

      Chronic.parse(time_or_string).try(:to_date)
    end

    def iso_8601_date(date)
      Chronic.parse(date).to_time.iso8601
    end

    def date_params(params)
      ca = params[:created_at] || {}
      ca[:start] = ca[:start].presence || 'one year ago'
      ca[:end] = ca[:end].presence || 'today'

      @date_start = parse_date_if_needed(ca[:start])
      @date_end = parse_date_if_needed(ca[:end])
    end
  end
end
