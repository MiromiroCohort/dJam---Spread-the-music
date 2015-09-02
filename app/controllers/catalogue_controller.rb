require 'mp3info'
require 'json'

class CatalogueController < ApplicationController


attr_reader :party_over

@party_over = false

  def import_library
    music_dir = '/media/mpd_music'
    Dir.foreach(music_dir) do |item|
      next if item == '.' or item == '..'
      this_track = Mp3Info.open("#{music_dir}/#{item}")
      if this_track.tag.artist
        thisTrack = Track.create playlist_id:0,
        playlist_position: 0,
        artist: this_track.tag.artist,
        title: this_track.tag.title,
        length:this_track.length,
        filename: item,
        vote_count: 1
      end
    end
  end

  def import_track
    music_dir = '/media/mpd_music'
    Dir.foreach(music_dir) do |item|
      next if item == '.' or item == '..'
      this_track = Mp3Info.open("#{music_dir}/#{item}")
      if this_track.tag.artist
        thisTrack = Track.create playlist_id:0,
        playlist_position: 0,
        artist: this_track.tag.artist,
        title: this_track.tag.title,
        length:this_track.length,
        filename: item,
        vote_count: 1
      end
    end
  end

  def self.transfer_to_client_dir(file_path_and_name)
    Net::SCP.upload!("127.0.0.1", "djam", file_path_and_name,  "/media/mpd_music", :ssh => { :password => "C#ristmas25" })
    new_track = Mp3Info.open(file_path_and_name)
    new_track = Track.create playlist_id:0,
    playlist_position: 0,
    artist: new_track.tag.artist,
    title: new_track.tag.title,
    length:new_track.length,
    filename: file_path_and_name,
    vote_count: 1
    File.delete(file_path_and_name)
  end

  def play_the_set
    SongController.begin_set
    redirect_to makelist
  end

  def search_for_string(search_string)
    # search for songs in the database
  end

  def get_now_playing
    now_playing = Playing.first
    return_hash = {:artist => now_playing.artist,
                   :title => now_playing.title,
                   :length => now_playing.length}
    render json: return_hash
  end

  def vote
    this_track = Track.find(params[:song_ref])
    this_track.vote_count +=1
    this_track.save
    render :nothing => true
  end

  def self.make_list
    if Track.first
      out_html = "<div class='container'>"
      Track.each do |play_item|
        out_html += "<div class='row'>"
        out_html += "<div class='vote-cell prime'>" + play_item.artist + " : "
          out_string = ""
          play_item.title.gsub(/\w+/) do |word|
            if word.upcase == word
              out_string << word.capitalize + " "
            else
              out_string << word + " "
            end
          end
        out_html += out_string + "</div>"
        out_html += "<div class='vote-cell count'>" + play_item.vote_count.to_s + "</div>"
        out_html += "<div class='vote-cell btn vote-btn' id='" + play_item.id + "'>&nbsp;</div>"
        out_html += "</div>"
      end
    else
      out_html = "<div class='container'><h2>Sorry - there are no items in this playlist</h2></div>"
    end
    return out_html
  end


end
