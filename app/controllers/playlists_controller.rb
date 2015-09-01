class PlaylistsController < ApplicationController

  def index
    p session[:host_id]["$oid"]
    p Host.all.to_a
    # @host = Host.where(:_id session[:host_id]["$oid"])
    # p @host.inspect
    # @playlists = Playlist.find
  end
end
