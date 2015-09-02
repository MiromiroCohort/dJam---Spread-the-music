require 'net/ssh'
require 'mongo'

class SongController < ApplicationController

  def self.open_ssh_connection
    session = Net::SSH.start('127.0.0.1', 'djam', :password => "C#ristmas25")
  end


  def self.begin_set
    first=true
    offset = 3
    this_song_hash = play_top(first)
    if not Playing.first
      playing_now = Playing.create
    else
      playing_now = Playing.first
    end
    playing_now.artist = this_song_hash[:artist]
    playing_now.title = this_song_hash[:song_title]
    playing_now.length = this_song_hash[:song_length]
    playing_now.save
    while not @party_over do
      first= false
      this_song_hash[:song_length].times do
        playing_now.length -=1
        p playing_now.length
        playing_now.save
        sleep 1
        if playing_now.length <= 0 
          this_song_hash = play_top(first)
          playing_now.artist = this_song_hash[:artist]
          playing_now.title = this_song_hash[:song_title]
          playing_now.length = this_song_hash[:song_length]
          playing_now.save
        end
      end
    end


  end

  def self.stop
    session = open_ssh_connection
      session.exec "mpc stop"
    session.close
  end

  
  def self.play_top(first)
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
      out_hash = {:artist => artx, :song_title => song, :song_length => length}
      artx = artx.split("'")[0]
      song = song.split("'")[0]
      if first
        exec_string = "mpc update; mpc clear; mpc crossfade 0; mpc consume on; mpc single off; mpc search artist '#{artx}' title '#{song}'| mpc add ; mpc play ; "
      else
        exec_string = "mpc search artist '#{artx}' title '#{song}' | mpc add ; mpc next ; mpc play"
      end
      session = open_ssh_connection
        session.exec "mpc crop"
        session.exec exec_string
      session.close
      this_track = Track.find(song_id)
      this_track.vote_count = 0
      this_track.save
      return out_hash
    end
  end
end


