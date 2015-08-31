require 'net/ssh'
require 'mongo'

class SongController < ApplicationController
  attr_reader :now_playing


  def open_ssh_connection
    session = Net::SSH.start('127.0.0.1', 'djam', :password => "C#ristmas25")
  end


  def stop
    session = open_ssh_connection
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
      artx = artx.split("'")[0]
      song = song.split("'")[0]
      if first
        exec_string = "mpc clear; mpc crossfade 20; mpc consume on; mpc single off; mpc search artist '#{artx}' title '#{song}'| mpc add ; mpc play ; "
      else
        exec_string = "mpc search artist '#{artx}' title '#{song}' | mpc add"
      end
    session = open_ssh_connection
        session.exec "mpc crop"
        session.exec exec_string
        session.exec "mpc idle"
      session.close
      this_track = Track.find(song_id)
      this_track.vote_count = 0
      this_track.save
      @now_playing = "#{artx} : #{song}"
      return length
    end
  end
end


