class Playlist
  include Mongoid::Document
  field :name, type: String
  belongs_to :host
  has_many :tracks
end
