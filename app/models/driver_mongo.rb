# coding: utf-8
class DriverMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_and_belongs_to_many :gundams

end