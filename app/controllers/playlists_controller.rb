class PlaylistsController < ApplicationController

  def index
     @host = Host.find_by(fbid: session[:host_id])
     p "The host for this playlist is: #{@host.name}"
  end

end
