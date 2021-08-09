require 'rails_helper'

RSpec.describe "Deletes a task", type: :feature do
  let(:user) {User.create!(email: 'test@example.com', password: 'password')}
  let (:category) { Category.create!(name: 'This is a category',
    image_url:'https://tinyurl.com/2vhaj485', user: user) }
  let (:task) { category.tasks.create!(name: 'Todo 1',
                    description: 'Walk with Pochi',
                    priority: '1',
                    deadline: '2021-08-20 05:59:02.287974000 +0000',
                    completed: 'false',
                    category_id: category.id,
                    user_id: user.id) }

  def login(user)
    visit home_index_path
    click_link 'Sign In'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  before do
    login(user)
    visit category_task_path(category, task)
  end


  it 'successfully' do
    expect(current_path).to eq category_task_path(category, task)
    expect(page).to have_content('Todo 1')
    task_count = category.tasks.count
    click_link 'Delete'
    visit category_path(category.id)
    expect(current_path).to eq category_path(category.id)
    expect(category.tasks.count).to eq(task_count - 1)

    #ActiveRecord methods to check if exact record is deleted from db
    expect { task.reload }.to raise_error(ActiveRecord::RecordNotFound)
    expect(category.tasks.exists?(task.id)).to be_falsey
  end
end
