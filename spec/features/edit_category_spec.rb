require 'rails_helper'

RSpec.describe 'Edits a category', type: :feature do
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
    visit edit_category_path(id: category.id)
  end

  it 'for valid inputs' do
    expect(current_path).to eq edit_category_path(id: category.id)
    fill_in 'Name', with: 'Work edited'
    fill_in 'Image url', with: 'https://tinyurl.com/sa9k2cep'
    #click submit button (in form, it is button)
    click_button 'Update Category'
    visit category_path(id: category.id)
    expect(current_path).to eq category_path(id: category.id)
    expect(page).to have_content('Work edited')
    find("img[src='https://tinyurl.com/sa9k2cep']")

    cat1 = Category.order("id").last
    expect(cat1.name).to eq('Work edited')
    expect(cat1.image_url).to eq('https://tinyurl.com/sa9k2cep')
  end

  it 'for invalid input (Name)' do
    expect(current_path).to eq edit_category_path(id: category.id)
    fill_in 'Name', with: ''
    click_button 'Update Category'
    expect(page).to have_content("Name can't be blank")
  end

  it 'for invalid input (Image url)' do
    expect(current_path).to eq edit_category_path(id: category.id)
    fill_in 'Image url', with: ''
    click_button 'Update Category'
    expect(page).to have_content("Image url can't be blank")
  end
end

