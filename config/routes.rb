Rails.application.routes.draw do
  resources :event_schedules
  resources :events
  resources :time_blocks
  resources :participants do
    collection do
      get  '/signup',  to: 'participants#new'
      get    '/login',   to: 'participant_sessions#new'
      post   '/login',   to: 'participant_sessions#create'
      delete '/logout',  to: 'participant_sessions#destroy'
    end
  end
  resources :organizers do
    collection do
      get  '/signup',  to: 'organizers#new'
      get    '/login',   to: 'organizer_sessions#new'
      post   '/login',   to: 'organizer_sessions#create'
      delete '/logout',  to: 'organizer_sessions#destroy'
    end
  end

  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
end
