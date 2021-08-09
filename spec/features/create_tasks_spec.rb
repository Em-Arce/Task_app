require 'rails_helper'

RSpec.describe "Creates a task", type: :feature do
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
    visit category_path(id: category.id)
  end


  it 'for valid inputs' do
    # visit specific category
    expect(current_path).to eq category_path(id: category.id)
    #fill in form with required info
    fill_in 'name', with: 'Todo 1'
    fill_in 'description', with: 'Walk with Pochi'
    fill_in 'priority', with: '1'
    fill_in 'deadline', with: '2021-08-20 05:59:02.287974000 +0000'
    #page.find('#task_deadline').click come back to this
    page.find('#task_completed option', :text => 'false').click
    #click submit button (in form, it is button)
    click_button 'Submit'
    #expect page to have the contents submitted
    expect(page).to have_content('This is a category')
    expect(page).to have_content('Todo 1')


    #check if task is saved in db
    task1 = Task.order("id").last
    expect(task1.name).to eq('Todo 1')
    expect(task1.description).to eq('Walk with Pochi')
    expect(task1.priority).to eq(1)
    expect(task1.deadline).to eq('2021-08-20 05:59:02.287974000 +0000')
    expect(task1.completed).to eq(false)
    expect(task1.user_id).to eq(user.id)
  end

  it 'for invalid input' do
    expect(current_path).to eq category_path(id: category.id)
    fill_in 'name', with: ''
    fill_in 'description', with: 'Walk with Pochi'
    fill_in 'priority', with: '1'
    fill_in 'deadline', with: '2021-08-20 05:59:02.287974000 +0000'
    page.find('#task_completed option', :text => 'false').click
    click_button 'Submit'
    #expect record not to be submitted and saved in db
    expect(page).to have_content('Invalid inputs.')
    expect(page).not_to have_content('Todo 1')
  end
end
