Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :users, only: [:create]
  post "/auth/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  post "/user/confirm", to: "users#confirm"
  post "/user/create", to: "users#create"
  get "/user/list", to: "users#list"
  get "/detail", to: "users#details"
end
