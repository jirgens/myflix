Myflix::Application.routes.draw do
  get "/home", to: "videos#index"
   # root to: "videos#index"

  resources :videos, only: [:show, :index] do
    collection do
      post :search, to: "videos#search"
    end
  end
  # get 'ui(/:action)', controller: 'ui'
  resources :categories, only: [:show, :index]


end
