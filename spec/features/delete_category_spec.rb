require 'rails_helper'

RSpec.describe 'Deletes a category', type: :feature do

  it 'success' do
    category = Category.create!(name: 'Work', image_url:'https://tinyurl.com/2vhaj485')
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Work')
    find("img[src='https://tinyurl.com/2vhaj485']")
    #use this if there are multiple buttons w/ same name in page else use click_link
    #first(:link, 'Delete').click
    category_count = Category.count
    click_link 'Delete'
    expect(Category.count).to eq(category_count - 1)
    expect(current_path).to eq categories_path
    expect(page).not_to have_content('Work')
    #ActiveRecord methods to check if exact record is deleted from db
    expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Category.exists?(category.id)).to be_falsey
  end
end
