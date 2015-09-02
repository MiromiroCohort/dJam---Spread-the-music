class Host
  include Mongoid::Document
  field :name, type: String
  field :fbid, type: String
  field :email, type: String
  has_many :playlists
end
