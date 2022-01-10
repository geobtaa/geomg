# frozen_string_literal: true

Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/overview', as: :reports
  get '/search' => 'search#index'

  resources :bulk_actions do
    patch :run, on: :member
    patch :revert, on: :member
  end

  resources :imports do
    resources :mappings
    resources :import_documents, only: [:show]
    patch :run, on: :member
  end

  resources :bookmarks
  delete '/bookmarks', to: 'bookmarks#destroy', as: :bookmarks_destroy_by_fkeys

  get 'users/index'

  resources :notifications do
    put 'batch', on: :collection
  end

  devise_for :users, controllers: { invitations: 'devise/invitations' }, skip: [:registrations]
  as :user do
    get '/sign_in' => 'devise/sessions#new' # custom path to login/sign_in
    get '/sign_up' => 'devise/registrations#new', as: 'new_user_registration' # custom path to sign_up/registration
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'documents#index'

  # public-facing routes
  resources :documents do
    resources :document_accesses, path: 'access' do
      collection do
        get 'import'
        post 'import'
      end
    end

    collection do
      get 'fetch'
    end
  end

  resources :document_accesses, path: 'access' do
    collection do
      get 'import'
      post 'import'
    end
  end

  mount Qa::Engine => '/authorities'
  mount ActionCable.server => '/cable'

  authenticate :user, ->(user) { user } do
    mount Blazer::Engine, at: 'blazer'
  end
end
