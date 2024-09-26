Rails.application.routes.draw do
  resources :orders
  resources :order_items
  resources :cart_items
  resources :products
  resources :addresses
  resources :company_users
  resources :companies
  resources :customers
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #

  post "login" => "authentication#login"
  post "register/user" => "authentication#register_user"
  post "register/customer" => "authentication#register_customer"
  get "/me" => "authentication#me"
  get "/products/company/:company_id" => "products#load_by_company"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
