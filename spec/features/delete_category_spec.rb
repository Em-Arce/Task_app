require 'rails_helper'

RSpec.describe 'Deletes a category', type: :feature do

  it 'success' do
    category = Category.create!(name: 'Work1')
    visit categories_path
    expect(current_path).to eq categories_path
    expect(page).to have_content('Work1')
    #use this if there are multiple buttons w/ same name in page else use click_link
    first(:link, 'Delete').click
    expect(current_path).to eq categories_path
    #rspec method to check if record is deleted from db
    expect { category.destroy }.to change { Category.count }.by(-1)
    #ActiveRecord methods to check if record is deleted from db
    expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(category.persisted?).to be_falsey
  end
end
