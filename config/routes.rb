Rails.application.routes.draw do
  get '/track/new' => 'track#new'
  get '/track/scrape' => 'track#scrape'
  post '/session' => 'session#new'
   root 'site#index'
  resources :users
  resources :hosts
  post '/track/add' => 'track#add'
  # root 'track#new'
  get '/playlists' => 'playlists#index'
  post '/vote' => 'catalogue#vote'
  get '/makelist' => 'catalogue#makelist'
  get '/playing' => 'catalogue#get_now_playing'
  get '/menu' => 'catalogue#menu'
  get '/import' => 'catalogue#import_library'
  get '/play' => 'catalogue#play_the_set'

  get '/api/v1/playlist' => 'api#all'
  get '/api/v1/playlist/:playlist_id/songs' => 'api#songs'

  post '/api/v1/playlist/song/vote' => 'api#vote'

end
