Rails.application.routes.draw do
  resources :motorcurier_orders
  resources :motor_curiers
  resources :orders
  resources :cart_items
  resources :products
  resources :addresses
  resources :company_users
  resources :companies
  resources :users
  resources :order_items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "login" => "authentication#login"
  post "register/user" => "authentication#register"
  post "login/motor_curier" => "authentication#authenticate_motor_curier"

  get "/me" => "authentication#me"
  get "/products/company/:company_id" => "products#load_by_company"
  get "/me/motor_curier" => "authentication#me_motor_curier"

  put "/location/motor_curiers" => "motor_curiers#update_location"

  put "/users" => "users#update"
  delete "/users" => "users#destroy"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount ActionCable.server => "/cable"

  # Defines the root path route ("/")
  # root "posts#index"
end
