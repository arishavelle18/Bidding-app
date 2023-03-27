Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # root
  root 'sessions#new'

  get 'users/new'
  # products
 
  get "products/" => "products#index", as:"products" 
  get 'product/new' => "products#new", as:"product_new"
  post 'products/' => "products#create"
  get 'product/:id' => "products#show", as:"product"
  get 'product/:id/edit/' => "products#edit", as:"product_edit"
  patch 'product/:id/edit/' => "products#update"
  delete 'products/:id/delete' => "products#destroy",as:"product_delete"
  get 'products/:id/delete' => "products#destroy"
  patch 'stopbid/:id' => "products#stopbid", as:"stop"
  get 'stopbid/:id/'  => "products#stopbid"
  # bidders
  get 'send-bid/:id' => 'bidders#new', as:"bid"
  post 'send-bid/:id' => 'bidders#create'

  # register
  get "register/" => "users#new", as:"user"
  post "register/" => "users#create"
  # view profile
  get "user/" => "users#show", as:"profile"
  # login
  get 'login/' => "sessions#new", as:"login"
  post 'login/' => "sessions#create"
  delete 'logout/' => "sessions#destroy"
  get 'logout/' => "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
