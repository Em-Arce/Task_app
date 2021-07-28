require 'rails_helper'

RSpec.describe 'Shows A Category', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'shows a category' do
    category = Category.create!(name: 'This is a category')
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
  end
end
