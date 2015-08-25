Rails.application.routes.draw do
  # get 'search/new'

  get '/search/new' => 'search#new'
  get '/search/scrape' => 'search#scrape'
  root 'site#index'
  resources :users
  resources :hosts
end
