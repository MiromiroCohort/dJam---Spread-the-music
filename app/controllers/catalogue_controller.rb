require 'mp3info'



class CatalogueController
  html_out = "<table><tr><th>Artist</th><th>Title</th><th>Track length</th></tr>"
  music_dir = '/home/del/music_temp'
  Dir.foreach(music_dir) do |item|
    next if item == '.' or item == '..'
    this_track = Mp3Info.open("#{music_dir}/#{item}")
    if this_track.tag.artist 
      db_track = Track.new
      db_track.artist = this_track.tag.artist
      db_track.save
    end
  end
  html_out << "</table>"
  p html_out
end
