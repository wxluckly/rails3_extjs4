class PeriodMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  belongs_to  :dimension
  has_many :gundams

end