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
    # flash.notice = "Your library has been imported!"
    # redirect_to menu_url
  end


  def play_the_set
    count = 1000
    song_ctl = SongController.new
    first=true
    while count >0 do
      delay = song_ctl.play_top(first)
      delay -= 15
      x = Thread.new { sleep delay }
      x.join
      count -=1
      first= false
    end
  end

  def search_playlist(search_string)

    # TODO add the ability to echo | grep the mpc playlist

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
        out_html += "<div class='row'><div class='vote-cell prime'" + play_item.artist + " : "
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
        out_html += "<div class='vote-cell vote-btn' id='" + play_item.id + "'>vote</div></div>"
      end
    else
      #error message here
    end
    return out_html
  end


  def menu
  end

end
