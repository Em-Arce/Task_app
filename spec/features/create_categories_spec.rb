require 'rails_helper'

RSpec.describe "CreateCategories", type: :system do
  before do
     driven_by(:rack_test)
  end

  it 'for valid inputs' do
    # visit root route
    visit '/'
    #click create category link
    click_link 'Create Category'
    #visit categories/new page
    visit '/categories/new'
    #fill in form with required info
    fill_in 'Name', with: 'This is a category'
    #click submit button
    click_button 'Create Category'
    #expect page to have the content submitted
    expect(page).to have_content('This is a category')
  end

  it 'for invalid inputs' do
    visit '/'
    click_link 'Create Category'
    visit '/categories/new'
    fill_in 'Name', with: ''
    click_button 'Create Category'
    expect(page).to have_content("Name can't be blank")
  end
end
