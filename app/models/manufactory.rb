# coding: utf-8
class Manufactory < ActiveRecord::Base
  include MongoSync

  has_many    :gundams

  attr_accessible :name, :summary, :gundam_id

  validates :name, :presence => true, :uniqueness => true
end