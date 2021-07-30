require 'rails_helper'

RSpec.describe 'Deletes a category', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'success' do
    Category.create!(name: 'This is a category')
    visit root_path
    expect(page).to have_content('This is a category')
    click_link 'Delete'
    expect(page).not_to have_content('This is a category')
  end
end
