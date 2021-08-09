require 'rails_helper'

RSpec.describe 'Shows a category', type: :feature do
  let(:user) {User.create!(email: 'test@example.com', password: 'password')}
  let(:category) {Category.create!(name: 'Work', image_url:'https://tinyurl.com/2vhaj485', user: user)}

  def login(user)
    visit home_index_path
    click_link 'Sign In'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  before do
    login(user)
    visit category_path(id: category.id)
  end

  it 'when Back is clicked redirects to Index Page' do
    expect(current_path).to eq category_path(id: category.id)
    click_link 'Back'
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Categories')
  end

  it 'when Edit is clicked redirects to Edit Page' do
    expect(current_path).to eq category_path(id: category.id)
    click_link 'Edit'
    visit edit_category_path(id: category.id)
    expect(current_path).to eq edit_category_path(id: category.id)
    expect(page).to have_content('Edit Category')
    expect(page).to have_content('Name')
    expect(page).to have_content('Image url')
  end

  it 'when Delete, redirects to Index Page' do
    expect(current_path).to eq category_path(id: category.id)
    click_link 'Delete'
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Categories')
  end
end
