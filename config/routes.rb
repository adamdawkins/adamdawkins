Rails.application.routes.draw do
  get ":year/:ordinal_day/t/:time" => "notes#show", 
      constraints: { year: /\d{4}/, ordinal_day: /\d{1,3}/, time: /\d{6}/ },
      as: :notes_permalink
  
  resources :notes do
    resources :publishings, only: :create
    delete "publishings" => "publishings#destroy"
  end
  
  get "articles/:year/:ordinal_day/t/:time(/:slug)" => "articles#show", 
      constraints: { year: /\d{4}/, ordinal_day: /\d{1,3}/, time: /\d{6}/ },
      as: :articles_permalink
  
  resources :articles do
    resources :publishings, only: :create
    delete "publishings" => "publishings#destroy"
  end

  namespace :adam do
    get "new"
    post "" => :create
    delete "" => :destroy
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
