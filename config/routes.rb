Rails.application.routes.draw do
  get '/search/new' => 'search#new'
  get '/search/scrape' => 'search#scrape'
  root 'search#new'
end
