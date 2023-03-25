Rails.application.routes.draw do
  # root
  root 'sessions#new'

  get 'users/new'
  # products
 
  get "products/" => "products#index", as:"products" 
  get 'product/new' => "products#new", as:"product_new"
  post 'products/' => "products#create"
  get 'product/:id/edit/' => "products#edit", as:"product_edit"
  patch 'product/:id/edit/' => "products#update"
  delete 'products/:id/delete' => "products#destroy",as:"product_delete"
  get 'products/:id/delete' => "products#destroy"


  # register
  get "register/" => "users#new", as:"user"
  post "register/" => "users#create"

  # login
  get 'login/' => "sessions#new", as:"login"
  post 'login/' => "sessions#create"
  delete 'logout/' => "sessions#destroy"
  get 'logout/' => "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
