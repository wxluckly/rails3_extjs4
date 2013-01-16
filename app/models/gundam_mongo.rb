class GundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  belongs_to :period
  belongs_to :usage

end
