class GundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :period, inverse_of: nil
  belongs_to :type, inverse_of: nil

  field :_id, type: Integer

end
