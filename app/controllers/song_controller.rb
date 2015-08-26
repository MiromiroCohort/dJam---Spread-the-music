require 'net/ssh'

class SongController < ApplicationController

  @host_address = '127.0.0.1'

  def play(artist, song_string)
    this_host = @host_address
    session = Net::SSH.start( this_host, 'djam', :password => "C#ristmas25" )
    # session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
    session.exec "mpc clear ; mpc search artist \"#{artist}\" | grep \'#{song_string}\' | mpc add ; mpc play"
    session.close
  end

  def stop
    session = Net::SSH.start( '127.0.0.1', 'djam', :password => "C#ristmas25" )
    # session = Net::SSH.start( '192.168.1.34', 'djam', :password => "C#ristmas25" )
      session.exec "mpc stop"
    session.close
  end

  
  def play_top
    highest = 0
    artx = ""
    song = ""
    Track.each do |item|
      if item[:vote_count] > highest
        highest = item[:vote_count]
        artx = item[:artist]
        song = item[:filename]
      end
    end
    play(artx, song)

  end


end


