class GundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_and_belongs_to_many :drivers
  has_and_belongs_to_many :forces
  belongs_to :period
  belongs_to :usage

end
