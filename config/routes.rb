Rails.application.routes.draw do
  resources :events do
    collection do
      get 'search'
      get 'do_search'
      post 'cancel', to: 'events#cancel'
    end
  end
  resources :participants do
    collection do
      get  '/signup',  to: 'participants#new'
      get    '/login',   to: 'participant_sessions#new'
      post   '/login',   to: 'participant_sessions#create'
      post 'add', to: 'participants#add_to_schedule'
      post 'remove', to: 'participants#remove_from_schedule'
    end
  end
  resources :organizers do
    collection do
      get  '/signup',  to: 'organizers#new'
      get    '/login',   to: 'organizer_sessions#new'
      post   '/login',   to: 'organizer_sessions#create'
    end
  end

  resources :rooms do
    collection do
      get 'search'
      get 'do_search'
      get 'search_available'
      get 'do_search_available'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#index'
  get '/logout', to: 'application#destroy_session'
end
