Rails.application.routes.draw do
  get '/search/new' => 'search#new'
  get '/search/scrape' => 'search#scrape'
  post '/session' => 'session#new'
  # root 'site#index'
  resources :users
  resources :hosts
  post '/search/add' => 'search#add'
  post '/vote' => 'catalogue#vote'
  get '/makelist' => 'catalogue#makelist'
  root 'search#new'
end
