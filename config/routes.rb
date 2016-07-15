Rails.application.routes.draw do
  
  root 'messages#index'
  resources :sessions, only: [:new, :create]

  delete '/logout' => "sessions#destroy"
  get '/login' => "sessions#new"
  get '/messages_sent' => "messages#messages_sent"
  resources :users
  resources :friendships, only: [:new, :create, :edit]
  resources :messages, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
