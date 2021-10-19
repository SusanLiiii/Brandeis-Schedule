Rails.application.routes.draw do
  resources :organizers
  resources :rooms
  resources :participants
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
  get  '/participantsignup',  to: 'participants#new'
  get  '/organizersignup',  to: 'organizers#new'
  get    '/participantlogin',   to: 'participant_sessions#new'
  post   '/participantlogin',   to: 'participant_sessions#create'
  delete '/participantlogout',  to: 'participant_sessions#destroy'
  get    '/organizerlogin',   to: 'organizer_sessions#new'
  post   '/organizerlogin',   to: 'organizer_sessions#create'
  delete '/organizerlogout',  to: 'organizer_sessions#destroy'
end
