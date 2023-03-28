# frozen_string_literal: true

Rails.application.routes.draw do
  resources :form_elements do
    post :sort, on: :collection
  end
  resources :form_header, path: :form_elements, controller: :form_elements
  resources :form_group, path: :form_elements, controller: :form_elements
  resources :form_control, path: :form_elements, controller: :form_elements
  resources :form_feature, path: :form_elements, controller: :form_elements

  get "reports/index"
  get "reports/overview", as: :reports
  get "/search" => "search#index"

  resources :bulk_actions do
    patch :run, on: :member
    patch :revert, on: :member
  end

  resources :imports do
    resources :mappings
    resources :import_documents, only: [:show]
    patch :run, on: :member
  end

  resources :elements do
    post :sort, on: :collection
  end

  resources :bookmarks
  delete "/bookmarks", to: "bookmarks#destroy", as: :bookmarks_destroy_by_fkeys

  get "users/index"

  resources :notifications do
    put "batch", on: :collection
  end

  devise_for :users, controllers: {invitations: "devise/invitations"}, skip: [:registrations]
  as :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", :as => "new_user_registration" # custom path to sign_up/registration
    get "users/edit" => "devise/registrations#edit", :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "documents#index"

  # public-facing routes
  resources :documents do
    get "versions"

    resources :document_accesses, path: "access" do
      collection do
        get "import"
        post "import"

        get "destroy_all"
        post "destroy_all"
      end
    end

    resources :document_downloads, path: "downloads" do
      collection do
        get "import"
        post "import"

        get "destroy_all"
        post "destroy_all"
      end
    end

    resources :document_assets, path: "assets" do
      collection do
        get "display_attach_form"
        post "attach_files"

        get "destroy_all"
        post "destroy_all"
      end
    end

    collection do
      get "fetch"
    end
  end

  resources :document_accesses, path: "access" do
    collection do
      get "import"
      post "import"

      get "destroy_all"
      post "destroy_all"
    end
  end

  resources :document_downloads, path: "downloads" do
    collection do
      get "import"
      post "import"

      get "destroy_all"
      post "destroy_all"
    end
  end

  resources :document_assets, path: "assets" do
    collection do
      get "display_attach_form"
      post "attach_files"

      get "destroy_all"
      post "destroy_all"
    end
  end

  get "/documents/:id/ingest", to: "document_assets#display_attach_form", as: "asset_ingest"
  post "/documents/:id/ingest", to: "document_assets#attach_files"
  mount Kithe::AssetUploader.upload_endpoint(:cache) => "/direct_upload", :as => :direct_app_upload

  resources :collections, except: [:show]

  # Note "assets" is Rails reserved word for routing, oops. So we use
  # asset_files.
  resources :assets, path: "asset_files", except: [:new, :create] do
    member do
      put "convert_to_child_work"
    end
  end

  mount Qa::Engine => "/authorities"
  mount ActionCable.server => "/cable"

  authenticate :user, ->(user) { user } do
    mount Blazer::Engine, at: "blazer"
  end
end
