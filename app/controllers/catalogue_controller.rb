require 'mp3info'



class CatalogueController
  html_out = "<table><tr><th>Artist</th><th>Title</th><th>Track length</th></tr>"
  music_dir = '/home/del/music_temp'
  Dir.foreach(music_dir) do |item|
     next if item == '.' or item == '..'
     this_track = Mp3Info.open("#{music_dir}/#{item}")
     if this_track.tag.artist 
      html_out << "<tr><td>" + this_track.tag.artist + "</td>"
      html_out << "<td>" + this_track.tag.title + "</td>"
      html_out << "<td>" + this_track.length.to_i.to_s + "</td>"
      html_out << "</tr>"
    end
  end
  html_out << "</table>"
  p html_out
end
