class Playlist
  include Mongoid::Document
  field :name, type: String
  belongs_to :host
  has_many :tracks

  def self.display(playlists)
    if playlists.first
      out_html = ""
      playlists.each do |playlist|
        out_html += "<div class='row'>"
        out_html += "<div class='prime playlists-item'>" + playlist.name
        out_html += "<form class='select-form' action='/playlists/" + playlist.id + "/show'>"
        out_html += "<input class='select-btn' type='submit' value=''>"
        out_html += "</form>"
        out_html += "</div>"
        out_html += "</div>"
      end
    else
      out_html = "<div class='container'><h2>Sorry - there are no items in this playlist</h2></div>"
    end
    return out_html
  end
end
