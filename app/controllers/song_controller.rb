require 'net/ssh'

class SongController < ApplicationController

  def play(artist, song_string)
    session = Net::SSH.start( '127.0.0.1', 'djam', :password => "C#ristmas25" )
    # session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
    session.exec "mpc clear ; mpc search artist #{artist} | grep #{song_string} | mpc add ; mpc play"
    session.close
  end

  def stop
    session = Net::SSH.start( '127.0.0.1', 'djam', :password => "C#ristmas25" )
    # session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
      session.exec "mpc stop"
    session.close
  end

end


