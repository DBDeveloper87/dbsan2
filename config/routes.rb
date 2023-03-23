Rails.application.routes.draw do
  require "domain_hosts"
  require "channel_subdomains"

  constraints(ChannelSubdomains) do
    root "channels/my_channel#show", as: :channel_root
    get 'settings', to: 'channels/my_channel#edit', as: "channel_settings"
    patch 'settings', to: 'channels/my_channel#update', as: "channel_update"
    resources :portfolio, controller: "portfolios"
    resources :playlists, controller: "videos/playlists"
    resources :videos do
      get "ad_menu", to: "videos#ad_menu"
      resources :text_tracks, controller: "videos/text_tracks" do
        get "captions", to: "videos/text_tracks#captions"
      end
      resources :cue_blocks, controller: "videos/cue_blocks"
    end
    resources :surveys do
      resources :sections, controller: "survey_sections"
      post "sections/new", to: "survey_sections#create"
    end
  end
  
  constraints subdomain: "store" do
    root "store/front#index", as: :store_root
    get "manage", to: "store/manage#index", as: :store_management
    resources :products, controller: "store/products"
    resources :departments, controller: "store/departments", param: :slug
    resources :product_categories, controller: "store/product_categories", param: :slug
    resources :product_image_sets, controller: "store/product_image_sets"
  end

  resources :uploads
  post "uploads/close", to: "uploads#close"
  
  
  root "channels/my_channel#show", subdomain: "www"
  
  

  get 'contenteditable', to: "pages#contenteditable"
  namespace :photos do
    get 'new', to: "images#new"
    post 'new', to: 'images#create'
  end

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
    get 'contact_info_report', to: 'camp_applications#contact_info_report'
    get 'meal_summary_report', to: 'camp_applications#meal_summary_report'
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
    resources :languages
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
  get "game_board", to: "pages#game_board"
  # Video
  get 'video_layout', to: "pages#video_layout"

  resources :donations do
    get "thank_you_note", to: "donations#thank_you_note"
  end
  get "donations_success", to: "donations#success"
  get "donations_thank_you", to: "donations#thank_you"
  resources :challenges do
    get 'shirts', to: 'challenge_participants#shirts'
    resources :participants, controller: "challenge_participants" do
      resources :activities, controller: "exercise_trackers"
    end
    resources :participant_milestones, controller: "participant_milestones" do
      post "notify", to: "participant_milestones#send_notification"
      get "accept", to: "participant_milestones#accept_or_decline"
      get "thanks", to: "participant_milestones#thanks"
    end
    resources :milestones, controller: "challenge_milestones"
    resources :faqs, controller: "fa_qs"
  end

end
