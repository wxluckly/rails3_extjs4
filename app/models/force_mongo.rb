# coding: utf-8
class ForceMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_and_belongs_to_many :gundams
end
