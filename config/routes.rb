Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'home/index'
  get 'categories/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :categories
end
