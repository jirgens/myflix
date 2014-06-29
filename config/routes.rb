Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: "categories#index"
   # root to: "videos#index"

  resources :videos, only: [:show] do
    resources :reviews, only: [:create]
  end
  
  resources :video_searches, only: [:create]

  resources :users, only: [:show, :create]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  # get 'ui(/:action)', controller: 'ui'
  resources :categories, only: [:show, :index]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'register', to: "users#new"
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'my_queue', to: "queue_items#index"
  resources :sessions, only: [:create]

  get 'forgot_password', to: 'forgot_passwords#new'     
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'

  resources :invitations, only: [:new, :create]
end
