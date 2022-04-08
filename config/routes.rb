Rails.application.routes.draw do
  resources :camps do
    resources :camp_applications do
      resources :camp_application_pis
      get 'camp_application_primary_phone/new', to: "camp_application_primary_phones#new"
      post 'camp_application_primary_phone/new', to: "camp_application_primary_phones#create"
      
      resources :camp_application_bis
      resources :camp_application_incs
      resources :camp_application_matchings
      resources :camp_application_ceus
      resources :camp_application_trainings
      resources :camp_application_cas
      resources :camp_application_shifts
      resources :camp_application_commitments
      resources :camp_application_lodgings
      resources :camp_application_meals
      resources :camp_application_medicals
      resources :camp_application_emergencies
      resources :camp_application_c3s
      resources :camp_application_permissions
      resources :camp_application_covids
      get 'next_steps', to: 'camp_applications#next_steps'
      post 'submit_application', to: 'camp_applications#submit_application'
      get 'c3_error', to: 'camp_applications#c3_error'
      get 'covid_error', to: 'camp_applications#covid_error'
      get 'success', to: 'camp_applications#success'
    end
    resources :camp_application_types
  end
  resources :phone_numbers
  
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
  post 'filter_address', to: 'admin/addresses#filter_address'
  
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
