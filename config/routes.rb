Rails.application.routes.draw do
  root 'breweries#index'

  get 'signin', to: 'sessions#new'
  get 'signup', to: 'users#new'
  post 'places', to: 'places#search'
  delete 'signout', to: 'sessions#destroy'

  resource :session, only: [:new, :create, :destroy]

  resources :beer_clubs
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :memberships, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :styles
  resources :users do
    post 'toggle_ban_status', on: :member
  end
end
