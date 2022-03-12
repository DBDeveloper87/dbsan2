Rails.application.routes.draw do
  # Get Time Zone
  post 'events/set_time_zone', to: 'events#set_time_zone'

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login'
    },
    controllers: {
      confirmations: "users/confirmations",
      passwords: "users/passwords",
      registrations: "users/registrations",
      sessions: "users/sessions",
      unlocks: "users/unlocks"
    }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Admin Console
  namespace :admin do
    get "/", to: "abouts#index"
    resources :countries, shallow: true do 
      resources :state_provinces
    end
    resources :abouts
    resources :board_members
    resources :social_networks
    resources :policies
    resources :bylaws, shallow: true do
      resources :bylaw_articles, except: [:index] do
        resources :bylaw_article_sections, except: [:index] do
          resources :bylaw_article_subsections, except: [:index]
        end
      end
    end
  end
  
  # Events
  resources :events, shallow: true do 
    resources :event_attendees
    resources :virtual_spaces do
      resources :zoom_meetings
    end
  end
  
  

  # Contact Form
  get 'contact', to: 'contacts#new'
  post 'contact', to: 'contacts#create'
  get 'message_sent', to: 'contacts#message_sent'
  
  # Get Pages
  get 'about', to: 'pages#who_we_are'
  get 'bylaws', to: "pages#bylaws"

  # Video
  get 'video_layout', to: "pages#video_layout"

  # Defines the root path route ("/")
  root "pages#home"
end
