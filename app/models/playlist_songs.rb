class PlaylistSongs
  include Mongoid::Document
  field :playlist, type: Integer
  field :song_id, 
end
