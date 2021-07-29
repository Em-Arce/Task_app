require 'rails_helper'

RSpec.describe 'Shows A Category', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'when Back is clicked redirects to Root/Index Page' do
    category = Category.create!(name: 'This is a category')
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Back'
    visit root_path
    expect(page).to have_content('Categories#index')
  end

  it 'when Edit is clicked redirects to Edit Page' do
    category = Category.create!(name: 'This is a category')
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Edit'
    visit edit_category_path(id: category.id)
    expect(page).to have_content('Edit Category')
    expect(page).to have_content('Name')
  end

  it 'when Delete is clicked redirects to Delete Popup Page' do
    category = Category.create!(name: 'This is a category')
   visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Delete'
    visit category_path(id: category.id, method: destroy)
    expect(page).to have_content('Are you sure?')
  end
end
