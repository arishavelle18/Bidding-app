Rails.application.routes.draw do
  root 'products#index'
  get "products/" => "products#index", as:"products" 
  get 'product/new' => "products#new", as:"product_new"
  post 'products/' => "products#create"
  get 'product/:id/edit/' => "products#edit", as:"product_edit"
  patch 'product/:id/edit/' => "products#update"
  delete 'products/:id/delete' => "products#destroy",as:"product_delete"
  get 'products/:id/delete' => "products#destroy"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
