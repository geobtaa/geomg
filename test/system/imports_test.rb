# frozen_string_literal: true

require 'application_system_test_case'

class ImportsTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:user_001)
    @import = imports(:one)
  end

  test 'visiting the index' do
    visit imports_url
    assert_selector 'h1', text: 'Imports'
  end

  test 'creating a Import' do
    visit imports_url
    click_on 'New Import'

    fill_in 'Name', with: @import.name
    fill_in 'Source', with: @import.source
    fill_in 'Description', with: @import.description

    attach_file('import_csv_file', Rails.root.join('test/fixtures/files/btaa_formatted_records.csv'))

    select 'BTAA CSV Template', from: 'import_type'

    click_on 'Create Import'

    assert_text 'Import was successfull'
  end

  test 'updating a Import' do
    visit imports_url
    click_on 'Edit', match: :prefer_exact

    fill_in 'Name', with: @import.name
    fill_in 'Source', with: @import.source
    fill_in 'Description', with: @import.description

    attach_file('import_btaa_csv_file', Rails.root.join('test/fixtures/files/btaa_formatted_records.csv'))

    click_on 'Update Import btaa'

    assert_text 'Import was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Import' do
    visit imports_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Import was successfully destroyed'
  end
end
