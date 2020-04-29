Rails.application.routes.draw do
  resources :imports
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'documents#index'

  # public-facing routes
  resources :documents

  mount Qa::Engine => '/authorities'
end
