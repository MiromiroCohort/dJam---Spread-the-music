class HostsController < ApplicationController

  def create
    @host = Host.create(email: params["email"])
    p @host.id
    session[:host_id] = @host.id
    redirect_to '/playlists'
  end
end
