Rails.application.routes.draw do
  get 'home/index'

  root 'categories#index'
  resources :categories
end
