require 'mp3info'


@party_over = false

class CatalogueController

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
               vote_count: 0
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



end
