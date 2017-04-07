Rails.application.routes.draw do

  root 'events#all_cards_today'

  get "auth/:provider/callback" => 'sessions#auth', as: :auth
  get "auth/failure" => 'sessions#auth_fail'

  get  'login'  => 'sessions#new'
  post 'login' => 'sessions#create'

  get  'logout' => 'sessions#destroy'
  post 'logout' => 'sessions#destroy'

  get 'events/duplicate_card' => 'events#duplicate_card'

  get 'events/cards' => 'events#cards'
  get 'cards' => 'events#all_cards_today'

  get 'mentors' => 'mentors#index'

  get 'topics' => 'teachers#topics'
  get 'staff' => 'teachers#staff'

  resources :users
  resources :events
  resources :marquees
  resources :calendars
end
