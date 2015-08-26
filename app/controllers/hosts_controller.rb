class HostsController < ApplicationController

  def create
    @host = Host.create(host_params)
    p "Host id: #{@host.id}. Host email: #{@host.email}"
    session[:host_id] = @host.id
    redirect_to '/playlists'
  end

  def host_params
    params.require(:host).permit(:email, :password)
  end
end
