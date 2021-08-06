Rails.application.routes.draw do
  get 'home/index'

  root 'categories#index'
  resources :categories do
    resources :tasks
  end
end
