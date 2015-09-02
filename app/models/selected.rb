class Selected
  include Mongoid::Document
  field :playlist_id, type: Integer
  field :username, type: String
end
