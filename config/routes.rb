Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace 'api' do
    resources :users
    resources :plants
    resources :sensors
    resources :parameters
    resources :lectures
    resources :usersensors
    resources :passwords
    resources :relay
  end

  post "/auth/login", to: "authentication#login"
end
