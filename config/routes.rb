Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'home/index'
  root 'home#index'
  resources :categories
end
