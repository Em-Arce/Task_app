require 'rails_helper'

RSpec.describe 'EditCategories', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'edits category, saves and shows edited category' do
    category = Category.order('id').last
    visit "/categories/#{category.id}/edit"
    fill_in 'Name', with: 'This is a category edited'
    click_button 'Create Category'
    expect(page).to have_content('This is a category edited')
  end
end
