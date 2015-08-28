Rails.application.routes.draw do
  get '/track/new' => 'track#new'
  get '/track/scrape' => 'track#scrape'
  post '/session' => 'session#new'
  # root 'site#index'
  resources :users
  resources :hosts
  post '/track/add' => 'track#add'
  root 'track#new'
  post '/vote' => 'catalogue#vote'
  get '/makelist' => 'catalogue#makelist'
end
