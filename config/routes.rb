Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :users
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
end
