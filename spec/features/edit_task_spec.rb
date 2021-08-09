require 'rails_helper'

RSpec.describe "Edits a task", type: :feature do
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
    visit edit_category_task_path(category, task)
  end


  it 'for valid inputs' do
    expect(current_path).to eq edit_category_task_path(category, task)
    #fill in form with required info
    fill_in 'Name', with: 'Todo 1'
    fill_in 'Description', with: 'Walk with Pochi edited'
    fill_in 'Priority', with: '1'
    fill_in 'Deadline', with: '2021-08-20 05:59:02.287974000 +0000'
    #page.find('#task_deadline').click come back to this
    page.find('#task_completed option', :text => 'false').click
    #click submit button (in form, it is button)
    click_on 'Update Task'
    #expect page to have the contents submitted
    expect(page).to have_content('This is a category')
    expect(page).to have_content('Walk with Pochi edited')

    #check if task is saved in db
    task1 = Task.order("id").last
    expect(task1.name).to eq('Todo 1')
    expect(task1.description).to eq('Walk with Pochi edited')
    expect(task1.priority).to eq(1)
    expect(task1.deadline).to eq('2021-08-20 05:59:02.287974000 +0000')
    expect(task1.completed).to eq(false)
    expect(task1.user_id).to eq(user.id)
  end
end
