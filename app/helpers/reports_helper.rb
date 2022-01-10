# frozen_string_literal: true

# ReportsHelper
module ReportsHelper
  def date_range_opts
    [
      { value: 'custom', display: 'Custom', selected: false },
      { value: 'today', display: 'Today', selected: false },
      { value: 'yesterday', display: 'Yesterday', selected: false },
      { value: 'lastweek', display: 'Last Week', selected: false },
      { value: 'lastmonth', display: 'Last Month', selected: false },
      { value: 'lastyear', display: 'Last Year', selected: false },
      { value: 'last7days', display: 'Last 7 Days', selected: false },
      { value: 'last4weeks', display: 'Last 4 Weeks', selected: true },
      { value: 'last30days', display: 'Last 30 Days', selected: false },
      { value: 'last365days', display: 'Last 365 Days', selected: false }
    ]
  end

  # Hash:
  #   => facet_label
  #   ==> facet_name
  #   ===> q1: facet_value
  #   ===> q2: facet_value
  def overview_facets(search, comparison: false)
    facet_table = {}

    # Populate q1 - Search Facets
    search.facets.each do |facet, values|
      facet_table[facet] ||= {}
      values.each_slice(2) do |name, count|
        facet_table[facet][name] ||= {}
        facet_table[facet][name]['q1'] = count
        facet_table[facet][name]['q2'] = 0
      end
    end

    # Populate q2 - Comparison Facets
    comparison&.facets&.each do |facet, values|
      facet_table[facet] ||= {}
      values.each_slice(2) do |name, count|
        facet_table[facet][name]['q2'] = count if facet_table[facet][name]
      end
    end

    # Delta
    facet_table.each do |key, _value|
      facet_table[key].each do |k, v|
        facet_table[key][k]['delta'] = delta_calc(v)
      end
    end

    facet_table
  end

  def delta_calc(value)
    q1 = value['q1'] || 0
    q2 = value['q2'] || 0
    percent_change(q1, q2)
  end

  def percent_change(now, orig)
    if orig.zero?
      pct_increase = 'N/A'
    else
      increase = now.to_f - orig.to_f
      pct_increase = ((increase / orig.to_f) * 100).round(0)
    end

    pct_increase
  end

  def link_from_solr(facet, name, total, params)
    params = params.to_unsafe_hash.with_indifferent_access.dup
    link = {}
    link[:facet] = facet
    link[:label] = name
    link[:count] = total
    link[:action] = add_or_remove_facet(facet, name, params)

    link[:url] = if link[:action] == 'add'
                   reports_url(facet_add_url(params, link))
                 else
                   reports_url(facet_remove_url(params, link))
                 end

    link
  end

  def add_or_remove_facet(facet, name, params)
    if params[:f] && params[:f][facet] && params[:f][facet].include?(name)
      'remove'
    else
      'add'
    end
  end

  def facet_add_url(params, link)
    params[:f] ||= {}
    params[:f][link[:facet]] ||= []
    params[:f][link[:facet]] << link[:label]
    params
  end

  def facet_remove_url(params, link)
    params[:f] ||= {}
    params[:f][link[:facet]] ||= []
    params[:f][link[:facet]].delete(link[:label])
    params
  end

  def overview_cell_color(facet_hash)
    if facet_hash['q1'] > facet_hash['q2']
      'table-success'
    elsif facet_hash['q1'] < facet_hash['q2']
      'table-danger'
    else
      ''
    end
  end
end
