require 'rails_helper'

RSpec.describe "Create a category", type: :feature do

  it 'for valid inputs' do
    # visit index
    visit categories_path
    #click create category link
    click_link 'Create Category'
    #visit categories/new page
    visit '/categories/new'
    #url must be in /categories/new
    expect(current_path).to eq new_category_path
    #fill in form with required info
    fill_in 'Name', with: 'This is a category'
    #click submit button (in form, it is button)
    click_button 'Create Category'
    #expect page to have the content submitted
    expect(page).to have_content('This is a category')

    #check if category is saved in db
    cat1 = Category.order("id").last
    expect(cat1.name).to eq('This is a category')
  end

  it 'for invalid inputs' do
    visit categories_path
    click_link 'Create Category'
    visit '/categories/new'
    fill_in 'Name', with: ''
    click_button 'Create Category'
    expect(page).to have_content("Name can't be blank")
  end
end
