# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pages
  resources :reports
  root "external#landing"

  get :admin, to: "admin#dashboard"
  namespace :admin do
    get :debug
    resources :users
  end

  resources :categories, only: [:edit, :update, :destroy] do
    collection do
      get :reorder
      post :reorder, action: "update_order"
    end
  end

  resources :documents, except: [:index, :show, :new, :create]

  scope module: :external do
    get :contact
    get :privacy_policy, path: "privacy-policy"
    get :version
  end

  resources :folders, except: [:show, :edit], path: "docs" do
    member do
      post :attach_file, path: "attach-file"
      post :attach_files, path: "attach-files"
    end
  end
  get "docs/:category/:folder", to: "folders#show", as: :category_folder
  get "docs/:category/:folder/edit", to: "folders#edit", as: :edit_category_folder
  get "docs/:category/:folder/upload", to: "folders#upload", as: :upload_category_folder
  post "docs/:category/:folder/download-zip", to: "folders#download_zip", as: :download_zip_category_folder
  get "docs/:category/:folder/*filename", to: "documents#download", as: :download_document, format: false
  get "docs/:category", to: redirect("docs"), as: :docs_category

  scope module: :internal do
    get :dashboard
    get :dashboard, as: :user_root
    get :directory
    get :search
    get :pareto
    get :report_page, path: "report/:page_id"
  end

  resources :pages do
    collection do
      post :add_report, path: "add-report"
    end
  end

  resources :profiles, only: [] do
    member do
      get :picture
    end
  end

  resources :projects

  resources :reports do
    member do
      get :refresh, to: redirect("reports/%{id}")
      post :refresh
    end
  end

  resources :report_rows, only: :new, path: "report-rows"

  get :settings, to: redirect("settings/profile")
  namespace :settings do
    get :profile
    patch :update_profile, path: "profile"
    patch :complete_profile, path: "complete-profile"
    get :profile_picture, path: "profile/picture", to: redirect("settings/profile")
    patch :update_profile_picture, path: "profile/picture"

    get :account
    patch :update_account, path: "account"
    get :password, to: redirect("settings/account")
    patch :update_password, path: "password"
    delete :destroy, path: "account", as: "delete_account"

    get :email
    patch :update_email, path: "email"
  end

  resources :sites

  get :coordinating_centers, to: "sites#coordinating_centers", path: "coordinating-centers"
  get :recruiting_centers, to: "sites#recruiting_centers", path: "recruiting-centers"

  devise_for :users,
             controllers: {
               confirmations: "confirmations",
               passwords: "passwords",
               registrations: "registrations",
               sessions: "sessions",
               unlocks: "unlocks"
             },
             path_names: { sign_up: "join", sign_in: "login" },
             path: ""
  resources :videos
end
