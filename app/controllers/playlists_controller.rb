class PlaylistsController < ApplicationController

  def index
     @host = Host.find_by(fbid: session[:host_id])
     @playlists = @host.playlists
  end

  def create
    @host = Host.find_by(fbid: session[:host_id])
    @host.playlists.create(name: params[:name])
    redirect_to '/playlists'
  end

  def show
    @playlist = Playlist.find_by(id: params[:id])
    p @playlist.name
  end

end
