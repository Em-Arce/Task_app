require 'rails_helper'

RSpec.describe 'Login', type: :feature do
    it 'with an existing user' do
        user = User.create!(email: 'bon@example.com', password: 'testtest')
        visit home_index_path
        click_link 'Sign In'
        fill_in 'user_email', with: 'bon@example.com'
        fill_in 'user_password', with: 'testtest'
        click_button 'Log in'
        expect(current_path).to eq categories_index_path
        expect(page).to have_content('Categories')
    end

    it 'with a blank email field' do
        user = User.create!(email: 'bon@example.com', password: 'testtest')
        visit home_index_path
        click_link 'Sign In'
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'testtest'
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end

    it 'with a blank password field' do
        user = User.create!(email: 'bon@example.com', password: 'testtest')
        visit home_index_path
        click_link 'Sign In'
        fill_in 'user_email', with: 'bon@example.com'
        fill_in 'user_password', with: ''
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end

    it 'both email and password fields are blank' do
        user = User.create!(email: 'bon@example.com', password: 'testtest')
        visit home_index_path
        click_link 'Sign In'
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end
end

RSpec.describe "Login form", type: :feature do
    it 'redirects to sign up page' do
        visit home_index_path
        click_link 'Sign In'
        click_link 'Sign up'
        expect(page).to have_content('Sign up')
        expect(current_path).to eq '/users/sign_up'
    end

    it 'redirects to forgot password page' do
        visit home_index_path
        click_link 'Sign In'
        click_link 'Forgot your password?'
        expect(page).to have_content('Forgot your password?')
        expect(current_path).to eq '/users/password/new'
    end
end