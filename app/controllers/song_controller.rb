require 'net/ssh'
require 'mongo'

class SongController < ApplicationController

  @now_playing = ""

  @host_address = '127.0.0.1'
# Runs onl localhost - check ifconfig for actual network address; prob: '192.168.1.34'
    host_address = @host_address
    session = Net::SSH.start( host_address, 'djam', :password => "C#ristmas25" )
    session.exec "mpc update"
    session.close



  def stop
    host_address = @host_address
    #cannot use @host_address directly due to SSH interpretation of @ symbol
    session = Net::SSH.start( host_address, 'djam', :password => "C#ristmas25" )
      session.exec "mpc stop"
    session.close
  end

  
  def play_top(first)
    highest = -1
    artx = ""
    song = ""
    song_id = ""
    length = 0 
    Track.each do |item|
      if item[:vote_count] > highest
        highest = item[:vote_count]
        artx = item[:artist]
        song = item[:title]
        length = item[:length]
        song_id = item[:_id]
      end
    end

    if highest == 0
      self.stop
    else 
      if first
        exec_string = "mpc clear; mpc crossfade 10; mpc consume on; mpc single off; mpc search artist '#{artx}' title '#{song}'| mpc add ; mpc play ; "
      else
        exec_string = "mpc findadd artist '#{artx}' title '#{song}'"
      end
      
      this_host = @host_address
      session = Net::SSH.start( this_host, 'djam', :password => "C#ristmas25" )
        session.exec "mpc crop"
        session.exec exec_string
        p exec_string
      session.close

      this_track = Track.find(song_id)
      this_track.vote_count = 0
      this_track.save
      @now_playing = "#{artx} : #{song}"
      return length
    end
    redirect_to :makelist
  end




end


