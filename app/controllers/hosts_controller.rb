class HostsController < ApplicationController

  def create
    @host = Host.create(params[:host])
    session[:host_id] = host.id
    redirect '/playlists'
  end
end
