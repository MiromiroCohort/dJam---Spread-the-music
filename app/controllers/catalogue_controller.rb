require 'mp3info'

class CatalogueController < ApplicationController

@party_over = false

  def import_library
    music_dir = '/home/del/music_temp'
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


  def play_the_set
    count = 1000
    song_ctl = SongController.new
    while count >0 do 
      delay = song_ctl.play_top
      p delay
      delay = 20
      x = Thread.new { sleep delay }  
      x.join
      count -=1
    end
  end

  def search_playlist(search_string)


  end


  def vote
    p "hello"
  end



  def generate_html_list
    if Track.first
      out_html = "<table><tr><th>Artist</th><th>Title</th></tr>"
      Track.each do |play_item|
        out_html += "<tr><td>" + play_item.artist + "</td><td>" + play_item.title + "</td><td><button class='vote_btn' id='" + play_item.id + "'>vote</button></td></tr>"
      end
      out_html += "</table>"
    else
      #error message here
    end
    return out_html
  end


  def record_song_vote(song_id)
    Track.find(song_id).vote_count +=1
  end

end
