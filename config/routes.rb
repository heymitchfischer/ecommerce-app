Rails.application.routes.draw do
  devise_for :users
  get '/' => 'products#index'
  get '/products' => 'products#index'
  get '/products/new' => 'products#new'
  post '/products' => 'products#create'
  get '/products/:id' => 'products#show'
  get '/products/:id/edit' => 'products#edit'
  put '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#destroy'
  get '/cart' => 'user_products#index'
  post '/cart' => 'user_products#create'
end
