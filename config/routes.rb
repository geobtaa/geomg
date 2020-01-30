Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # public-facing routes
  resources :documents

  mount Qa::Engine => '/authorities'
end
