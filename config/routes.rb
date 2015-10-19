Rails.application.routes.draw do

  root 'meetups#cards'

  get  'login'  => 'sessions#new'
  post 'login' => 'sessions#create'

  get  'logout' => 'sessions#destroy'
  post 'logout' => 'sessions#destroy'

  get 'meetups/cards' => 'meetups#cards'

  resources :users
  resources :meetups
  resources :events
  resources :slides
  resources :marquees

end
