Rails.application.routes.draw do
  # get '/track/new' => 'track#new'
  get '/track/scrape' => 'track#scrape'
  post '/session' => 'session#new'
  root 'site#index'
  resources :users
  resources :hosts
  get '/search' => 'track#find_playlist'
  post '/track/add' => 'track#add'
  get '/search/:id' => 'track#new'
  get '/playlists' => 'playlists#index'
  post '/playlists' => 'playlists#create'
  post '/vote' => 'catalogue#vote'
  get '/makelist' => 'catalogue#makelist'
  get '/playing' => 'catalogue#get_now_playing'
  get '/menu' => 'catalogue#menu'
  get '/import' => 'catalogue#import_library'
  get '/play' => 'catalogue#play_the_set'
  get '/' => 'site#index'
  get '/playlists/:id/show' => 'playlists#show'
  get '/api/v1/playlist' => 'api#all'
  get '/api/v1/playlist/:playlist_id/songs' => 'api#songs'

  post '/api/v1/playlist/song/vote' => 'api#vote'

end
