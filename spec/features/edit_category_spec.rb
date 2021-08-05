require 'rails_helper'

RSpec.describe 'Edits a category', type: :feature do

  it 'valid inputs' do
    category = Category.create!(name: 'Work', image_url:'https://tinyurl.com/2vhaj485')
    visit edit_category_path(id: category.id)
    expect(current_path).to eq edit_category_path(id: category.id)
    fill_in 'Name', with: 'Work edited'
    fill_in 'Image url', with: 'https://tinyurl.com/sa9k2cep'
    #click submit button (in form, it is button)
    click_button 'Update Category'
    expect(page).to have_content('Work edited')
    find("img[src='https://tinyurl.com/sa9k2cep']")

    cat1 = Category.order("id").last
    expect(cat1.name).to eq('Work edited')
    expect(cat1.image_url).to eq('https://tinyurl.com/sa9k2cep')
  end
end

