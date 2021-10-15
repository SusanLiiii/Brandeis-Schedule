Rails.application.routes.draw do
  resources :organizers
  resources :rooms
  resources :participants
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
end
