Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :galleries do
    resources :photos, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
    resource :bookmark, only: [:create, :destroy]
  end

  get '/search', to: 'galleries#search', as: 'search'
  get "/bookmarked", to: "bookmarks#index", as: "bookmarked_galleries"

  # Defines the root path route ("/")
  root "pages#home"
end
