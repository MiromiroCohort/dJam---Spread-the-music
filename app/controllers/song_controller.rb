require 'net/ssh'

class SongController < ApplicationController

  def play
    session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
      session.exec "mpc clear ; mpc search track 18 | mpc add ; mpc play"
    session.close
  end

  def stop
    session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
      session.exec "mpc stop"
    session.close
  end

end
