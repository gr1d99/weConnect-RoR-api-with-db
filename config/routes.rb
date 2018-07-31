Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/login', to: 'authentication#login'
  post '/register', to: 'authentication#register'
  resources :category
  resources :locations
  resources :businesses
end
