class PlaylistController < ApplicationController

  def host
    p session[:host_id].values[0]
    @host = Host.find_by id: session[:host_id].values[0]
    p "Host: #{@host.inspect}"
  end
end
