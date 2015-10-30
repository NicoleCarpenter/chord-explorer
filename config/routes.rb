Rails.application.routes.draw do

  # resources :included_chords
  # resources :user_songs
  # resources :user_saved_chords
  # resources :tabs
  # resources :songs

  resources :chords, only: [:index, :show]

  resources :users, only: [:new, :create, :show]

  get 'welcome/index'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'welcome#index'

end
