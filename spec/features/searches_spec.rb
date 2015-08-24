require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  scenario 'user can see the form on the page' do
    visit new_search_path

    expect(page).to have_selector('form')
  end

  scenario 'user can complete and submit a search' do
    visit new_search_path

    fill_in 'Search', with: "Nicolas Jaar el bandido"

    click_button 'Search'

    expect(page).to have_content('found')
  end
end
