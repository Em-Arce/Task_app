require 'rails_helper'

RSpec.describe 'Shows a category', type: :feature do
  let (:category) { Category.create(name: 'This is a category',
    image_url:'https://tinyurl.com/2vhaj485') }

  it 'when Back is clicked redirects to Index Page' do
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Back'
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Categories')
  end

  it 'when Edit is clicked redirects to Edit Page' do
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Edit'
    visit edit_category_path(id: category.id)
    expect(current_path).to eq edit_category_path(id: category.id)
    expect(page).to have_content('Edit Category')
    expect(page).to have_content('Name')
    expect(page).to have_content('Image url')
  end

  it 'when Delete, redirects to Index Page' do
    visit category_path(id: category.id)
    expect(page).to have_content('This is a category')
    click_link 'Delete'
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Categories')
  end
end
