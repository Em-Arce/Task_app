require 'rails_helper'

RSpec.describe 'Shows A Category', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'when Edit is clicked redirects to Edit Page' do
    category = Category.create!(name: 'This is a category')
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Edit'
    visit edit_category_path(id: category.id)
    expect(page).to have_content('This is a category')
    expect(page).to have_button('Update Category')
  end
end
