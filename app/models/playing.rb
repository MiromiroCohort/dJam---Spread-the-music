class Playing
  include Mongoid::Document
  field :artist, type: String
  field :title, type: String
  field :length, type: Integer
end
