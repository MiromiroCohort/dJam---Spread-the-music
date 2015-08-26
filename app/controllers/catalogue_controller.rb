require 'mp3info'

class CatalogueController
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
             filename: item
    end
  end
end
