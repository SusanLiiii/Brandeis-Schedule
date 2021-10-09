Rails.application.routes.draw do
  resources :time_blocks
  resources :rooms
  resources :events
  resources :departments
  resources :participants
  resources :organizers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
