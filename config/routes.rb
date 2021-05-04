# frozen_string_literal: true

Rails.application.routes.draw do
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

  mount Qa::Engine => '/authorities'

  concern :gbl_exportable, Geoblacklight::Routes::Exportable.new
  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :gbl_exportable
  end
  concern :gbl_wms, Geoblacklight::Routes::Wms.new
  namespace :wms do
    concerns :gbl_wms
  end
  concern :gbl_downloadable, Geoblacklight::Routes::Downloadable.new
  namespace :download do
    concerns :gbl_downloadable
  end
  resources :download, only: [:show]
  mount Geoblacklight::Engine => 'geoblacklight'
end
