Rails.application.routes.draw do
  resources :participants do
    collection do
      get  '/signup',  to: 'participants#new'
    end
  end
  resources :organizers
  resources :rooms
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
  
  # get  '/participant/signup',  to: 'participants#new'
  # get  '/organizer/signup',  to: 'organizers#new'
  # get    '/participant/login',   to: 'participant_sessions#new'
  # post   '/participant/login',   to: 'participant_sessions#create'
  # delete '/participant/logout',  to: 'participant_sessions#destroy'
  # get    '/organizer/login',   to: 'organizer_sessions#new'
  # post   '/organizer/login',   to: 'organizer_sessions#create'
  # delete '/organizer/logout',  to: 'organizer_sessions#destroy'
end
