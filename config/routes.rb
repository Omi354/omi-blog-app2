require "sidekiq/web"

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  root to: "articles#index"

  resources :articles do
    resources :comments, only: [ :index, :new, :create ]
    resource :like, only: [ :create, :destroy, :show ]
  end

  resources :accounts, only: [ :show ] do
    resources :followings, only: [ :index, :create, :destroy ]
  end
  resources :favorites, only: [ :index ]
  resource :profile, only: [ :show, :edit, :update ]
  resource :timeline, only: [ :show ]
end
