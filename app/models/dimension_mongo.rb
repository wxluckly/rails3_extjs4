class DimensionMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_many :periods

end
