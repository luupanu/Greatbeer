Rails.application.routes.draw do
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
