require 'net/ssh'
require 'mongo'

class SongController < ApplicationController

  @host_address = '127.0.0.1'
# Runs onl localhost - check ifconfig for actual network address; prob: '192.168.1.34'


  def play(artist, song_string)
  end

  def stop
    host_address = @host_address
    #cannot use @host_address directly due to SSH interpretation of @ symbol
    session = Net::SSH.start( host_address, 'djam', :password => "C#ristmas25" )
      session.exec "mpc stop"
    session.close
  end

  
  def play_top
    highest = -1
    artx = ""
    song = ""
    song_id = ""
    length = 0 
    Track.each do |item|
      if item[:vote_count] > highest
        highest = item[:vote_count]
        artx = item[:artist]
        song = item[:filename]
        length = item[:length]
        song_id = item[:_id]
      end
    end
    this_host = @host_address
    session = Net::SSH.start( this_host, 'djam', :password => "C#ristmas25" )
      session.exec "mpc clear ; mpc search artist \"#{artx}\" | grep \'#{song}\' | mpc add ; mpc play"
    session.close
    Track.find(song_id).remove
    return length

  end




end


