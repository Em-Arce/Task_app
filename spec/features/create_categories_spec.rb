require 'rails_helper'

RSpec.describe "Create a category", type: :system do
  before do
     driven_by(:rack_test)
  end

  it 'for valid inputs' do
    # visit root route
    visit root_path
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

    cat1 = Category.order("id").last
    expect(cat1.name).to eq('This is a category')
  end

  it 'for invalid inputs' do
    visit root_path
    click_link 'Create Category'
    visit '/categories/new'
    fill_in 'Name', with: ''
    click_button 'Create Category'
    expect(page).to have_content("Name can't be blank")
  end
end
