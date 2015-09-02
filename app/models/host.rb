class Host
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :uid, type: String
  field :image_url, type: String
end
