Rails.application.routes.draw do

  # For Users
  resource :users, only: [:create]
  post "/auth/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  post "/user/confirm", to: "users#confirm"
  post "/user/create", to: "users#create"
  get "/user/list", to: "users#list"
  get "/detail", to: "users#details"
  put "/update", to: "users#update"
  put "/user/get", to: "users#get"
  put "/user/delete", to: "users#delete"

  # For Posts
  get "/post/list", to: "posts#list"
end
