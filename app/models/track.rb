class Track
  include Mongoid::Document
  field :playlist_id, type: Integer
  field :vote_count, type: Integer
  field :artist, type: String
  field :title, type: String
  field :length, type: Integer
  field :filename, type: String
  belongs_to :playlist
end
