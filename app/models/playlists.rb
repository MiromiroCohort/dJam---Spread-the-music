class Playlists
  include Mongoid::Document
  field :userid, type: String
  field :playlist, type: Integer
end
