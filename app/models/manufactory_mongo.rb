# coding: utf-8
class ManufactoryMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_many :gundams
end