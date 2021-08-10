require 'rails_helper'

RSpec.describe 'Deletes a category', type: :feature do
  let(:user) {User.create!(email: 'test@example.com', password: 'password')}
  let (:category) { Category.create(name: 'This is a category',
                      image_url:'https://tinyurl.com/2vhaj485', user: user) }

  def login(user)
    visit home_index_path
    click_link 'Sign In'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  before do
    login(user)
    visit category_path(category)
  end

  it 'success' do
    expect(current_path).to eq category_path(category)
    category_count = Category.count
    #use this if there are multiple buttons w/ same name in page else use click_link
    #first(:link, 'Delete').click
    click_link 'Delete'
    expect(Category.count).to eq(category_count - 1)

    #ActiveRecord methods to check if exact record is deleted from db
    expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Category.exists?(category.id)).to be_falsey
  end
end
