require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  scenario 'user can see the form on the page' do
    visit root_path

    expect(page).to have_selector('#query')
  end

  scenario 'user can complete and submit a search' do
    visit search_new_path

    fill_in :query, :with => "Nicolas Jaar el bandido"

    click_button 'Search!'

    expect(page).to have_content('Scraping')
  end
end
