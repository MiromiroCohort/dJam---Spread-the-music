class SessionController < ApplicationController

  def new
    p params
    p params[:email]
    @host = Host.find_by(email: params[:email])
    p "Host found: #{@host.name}"
    if @host
      p @host.id
      session[:host_id] = @host.id
      redirect '/playlists'
    else
      @host = Host.create(email: params[:email], name: params[:name])
      p "Host created: #{@host.name}"
      p @host.id
      session[:host_id] = @host.id
      redirect '/playlists'
    end
    "Host not found: #{@host}"
    @login_error = true
  end

  def delete
    session[:host_id] = nil
    redirect '/'
  end
end
