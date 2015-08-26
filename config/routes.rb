Rails.application.routes.draw do
  get '/search/new' => 'search#new'
  get '/search/scrape' => 'search#scrape'
  post '/search/add' => 'search#add'

  root 'search#new'
end
