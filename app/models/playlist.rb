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
        out_html += "<div class='select-btn' " + playlist.name + "'>&nbsp;</div>"
        out_html += "</div>"
        out_html += "</div>"
      end
    else
      out_html = "<div class='container'><h2>Sorry - there are no items in this playlist</h2></div>"
    end
    return out_html
  end
end
