# frozen_string_literal: true

require 'test_helper'

class DocumentHelperTest < ActionView::TestCase
  # Remove remote server, direct locally
  test 'localize_link' do
    remote_link = 'https://geodev.btaa.org/admin/api.json?q=water\u0026search_field=all_fields\u0026sort=solr_year_i+desc%2C+dc_title_sort+asc'
    local_link = localize_link(remote_link)

    assert_equal '/documents?q=water\\u0026search_field=all_fields\\u0026sort=solr_year_i+desc%2C+dc_title_sort+asc', local_link
  end

  # Render local sort link from API results
  test 'sort_link' do
    @documents = BlacklightApi.new(
      **{
        q: 'water',
        page: 1,
        sort: 'solr_year_i+desc%2C+dc_title_sort+asc',
        rows: 20
      }
    )

    link = @documents.sorts.first

    assert_equal '<a class="dropdown-item" href="/documents?page=1&amp;q=water&amp;rows=20&amp;sort=score+desc%2C+dct_title_sort+asc">Relevance</a>', link_to(link['attributes']['label'], localize_link(link['links']['self']), { class: 'dropdown-item' })
  end

  # Render local link from API results
  test 'link_from_api - facet add link' do
    skip('@TODO')
    @documents = BlacklightApi.new(
      'water',                                  # query
      [],                                       # facets
      1,                                        # page
      'solr_year_i+desc%2C+dc_title_sort+asc',  # sort
      20                                        # per_page
    )

    facet = @documents.facets.select{ |f| f['id'] == 'b1g_genre_sm' }.first
    facet_item = facet['attributes']['items'].first
    agg = link_from_api(facet_item)

    assert_equal 'add', agg[:action]

    # Facet is added to query
    assert_equal '/documents?f%5Bb1g_genre_sm%5D%5B%5D=Geospatial+data&q=water&rows=20&sort=solr_year_i%2Bdesc%252C%2Bdc_title_sort%2Basc', agg[:link]
  end

  test 'link_from_api - facet remove link' do
    skip('@TODO')
    @documents = BlacklightApi.new('water', b1g_genre_sm: ['Geospatial data'])
    facet = @documents.facets.select{ |f| f['id'] == 'b1g_genre_sm' }.first
    facet_item = facet['attributes']['items'].first
    agg = link_from_api(facet_item)
    assert_equal 'remove', agg[:action]
  end

  test 'previous_link' do
    skip('@TODO')
    @documents = BlacklightApi.new(
      'water',                                  # query
      [],                                       # facets
      2,                                        # page
      'solr_year_i+desc%2C+dc_title_sort+asc',  # sort
      20                                        # per_page
    )

    prev = previous_link(@documents.links)

    assert_match(/1/, prev)
  end

  test 'next_link present' do
    skip('@TODO')
    @documents = BlacklightApi.new(
      'water',                                  # query
      [],                                       # facets
      1,                                        # page
      'solr_year_i+desc%2C+dc_title_sort+asc',  # sort
      20                                        # per_page
    )

    next_ = next_link(@documents.links)

    assert_match(/2/, next_)
  end

  test 'next_link - not present' do
    @documents = BlacklightApi.new(
      **{
        q: 'afafdafds',
        page: 1,
        sort: 'solr_year_i+desc%2C+dc_title_sort+asc',
        rows: 20
      }
    )

    next_ = next_link(@documents.links)

    assert_match(/aria-disabled/, next_)
  end

  test 'blacklight_link' do
    @document = Document.find_by!(friendlier_id: '35c8a641589c4e13b7aa11e37f3f00a1_0')
    bl_link = blacklight_link(@document)

    assert_includes(bl_link, '/catalog/35c8a641589c4e13b7aa11e37f3f00a1_0')
  end

  test 'publication_state_badge' do
    skip("@TODO: badge generation in test throws error: encoding: US-ASCII")
    @document = Document.find_by!(friendlier_id: '35c8a641589c4e13b7aa11e37f3f00a1_0')
    output = publication_state_badge(@document).to_s
    assert_match(/badge-secondary/, output)
    assert_match(/Draft/, output)

    @document.publication_state = 'Published'
    output = publication_state_badge(@document).to_s
    assert_match(/badge-success/, output)
    assert_match(/Published/, output)

    @document.publication_state = 'Unpublished'
    output = publication_state_badge(@document).to_s
    assert_match(/badge-danger/, output)
    assert_match(/Unpublished/, output)
  end
end
