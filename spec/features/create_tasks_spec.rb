require 'rails_helper'

RSpec.describe "Creates a task", type: :feature do
let (:category) { Category.create(name: 'This is a category',
    image_url:'https://tinyurl.com/2vhaj485') }

  it 'for valid inputs' do
    # visit specific category
    visit category_path(id: category.id)
    #click create task link
    click_button 'Create Task'
    #visit tasks/new page
    visit new_category_task_path
    #url must be in /tasks/new
    expect(current_path).to eq new_category_task_path
    #fill in form with required info
    fill_in 'Name', with: 'Todo 1'
    fill_in 'Description', with: 'Walk with Pochi'
    fill_in 'Priority', with: '1'
    fill_in 'Deadline', with: '2021-08-07 05:59:02.287974000 +0000'
    #click submit button (in form, it is button)
    click_button 'Create Task'
    #expect page to have the contents submitted
    expect(page).to have_content('This is a category')

    #check if task is saved in db
    task1 = Task.order("id").last
    expect(task1.name).to eq('Todo 1')
    expect(task1.description).to eq('Walk with Pochi')
    expect(task1.priority).to eq('1')
    expect(task1.deadline).to eq('2021-08-07 05:59:02.287974000 +0000')
  end

  it 'for invalid input (Name)' do
    visit category_tasks_path
    click_link 'Create Task'
    visit new_category_task_path
    expect(current_path).to eq new_category_task_path
    fill_in 'Name', with: ''
    click_button 'Create Task'
    expect(page).to have_content("Name can't be blank")
  end

  it 'for invalid input (Description)' do
    visit category_tasks_path
    click_link 'Create Task'
    visit new_category_task_path
    expect(current_path).to eq new_category_task_path
    fill_in 'Description', with: ''
    click_button 'Create Task'
    expect(page).to have_content("Description can't be blank")
  end

  it 'for invalid input (Priority)' do
    visit category_tasks_path
    click_link 'Create Task'
    visit new_category_task_path
    expect(current_path).to eq new_category_task_path
    fill_in 'Priority', with: ''
    click_button 'Create Task'
    expect(page).to have_content("Priority can't be blank")
  end

  it 'for invalid input (Deadline)' do
    visit category_tasks_path
    click_link 'Create Task'
    visit new_category_task_path
    expect(current_path).to eq new_category_task_path
    fill_in 'Deadline', with: ''
    click_button 'Create Task'
    expect(page).to have_content("Deadline can't be blank")
  end
end
