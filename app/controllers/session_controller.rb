class SessionController < ApplicationController

  def new
    @host = Host.find_by(email: params[:email])
    p "first"
    if @host
      p @host.fbid
      p "here"
      session[:host_id] = @host.fbid
      redirect_to '/playlists'
    else
      @host = Host.create(email: params[:email], name: params[:name], fbid: params[:id])
      p "Host created: #{@host.name}"
      p @host.fbid
      session[:host_id] = @host.fbid
      redirect_to '/playlists'
    end
    "Host not found: #{@host}"
    @login_error = true
  end

  def delete
    session[:host_id] = nil
    redirec_to '/'
  end
end
