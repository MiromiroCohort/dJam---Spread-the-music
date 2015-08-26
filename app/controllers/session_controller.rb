class SessionController < ApplicationController

  def new
    host = Host.find_by_email(params[:email])
    if host
      if host.password == params[:password]
        session[:host_id] = host.id
        redirect '/host'
      end
    end
    @login_error = true
    redirect '/playlists'
  end

  def delete
    session[:host_id] = nil
    redirect '/'
  end
end
