class Host
  include Mongoid::Document
  field :password, type: String
  field :email, type: String
  field :uid, type: String
  field :image_url, type: String
end
