require 'rails_helper'

RSpec.describe "Creates a category", type: :feature do
  let(:user) {User.create!(email: 'test@example.com', password: 'password')}

  def login(user)
    visit home_index_path
    click_link 'Sign In'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  before do
    login(user)
    # visit categoriesindex
    visit categories_path
    #click create category link
    click_link 'Create New Category'
    #visit categories/new page
    visit new_category_path
  end

  it 'for valid inputs' do
    #url must be in /categories/new
    expect(current_path).to eq new_category_path
    #fill in form with required info
    fill_in 'Name', with: 'This is a category'
    fill_in 'Image url', with: 'https://tinyurl.com/2vhaj485'
    #click submit button (in form, it is button)
    click_button 'Submit'
    #expect page to have the contents submitted
    expect(page).to have_content('This is a category')
    #expect(page).to have_css("img[src*='https://tinyurl.com/2vhaj485']") ok
    #find("img[src*='https://tinyurl.com/2vhaj485']") ok
    #below is capybara code to find aimage that begins with
    # source: https://stackoverflow.com/questions/14635474/how-to-use-regex-in-a-capybara-finder/14635989#14635989
    find("img[src='https://tinyurl.com/2vhaj485']")

    #check if category is saved in db
    cat1 = Category.order("id").last
    expect(cat1.name).to eq('This is a category')
    expect(cat1.image_url).to eq('https://tinyurl.com/2vhaj485')
  end

  it 'for invalid input (Name)' do
    expect(current_path).to eq new_category_path
    fill_in 'Name', with: ''
    click_button 'Submit'
    expect(page).to have_content("Name can't be blank")
  end

  it 'for invalid input (Image)' do
    expect(current_path).to eq new_category_path
    fill_in 'Image url', with: ''
    click_button 'Submit'
    expect(page).to have_content("Image url can't be blank")
  end
end
