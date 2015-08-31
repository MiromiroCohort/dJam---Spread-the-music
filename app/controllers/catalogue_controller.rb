require 'mp3info'

class CatalogueController < ApplicationController

attr_reader :playing_now

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

  def self.transfer_to_client_dir(file_path_and_name)
    Net::SCP.upload!("192.168.1.34", "djam", file_path_and_name,  "/media/mpd_music", :ssh => { :password => "C#ristmas25" })
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
    count = 1000
    song_ctl = SongController.new
    first=true
    offset = 10
    while count >0 do
      delay = (song_ctl.play_top(first)) - offset
      first= false
      # TODO - update front_end with revised playlist when next track taken
      for i in 0..delay do
        sleep 1
        p "Next track countdown: " + (delay - i).to_s + " seconds"
        # TODO push to front end
      end
    end
  end

  def search_playlist(search_string)
    # TODO Ajax call to search db
  end

  def vote
    this_track = Track.find(params[:song_ref])
    this_track.vote_count +=1
    this_track.save
  end

  def generate_html_list
    if Track.first
      out_html = "<div class='container'>"
      Track.each do |play_item|
        out_html += "<div class='row'><div class='vote-cell prime' width=70%>" + play_item.artist + " : " 
        out_string = ""
        play_item.title.gsub(/\w+/) do |word|
          if word.upcase == word
            out_string << word.capitalize + " "
          else 
            out_string << word + " "
          end
        end
        out_html += out_string + "</div>"
        out_html += "<div class='vote-cell count' width=10%>" + play_item.vote_count.to_s + "</div>"
        out_html += "<div class='vote-cell vote-btn' width=10% id='" + play_item.id + "'>vote</div></div>"
      end
    else
      out_html = "<div class='container'><h2>Sorry - there are no items in this playlist</h2></div>"
    end
    return out_html
  end


end
