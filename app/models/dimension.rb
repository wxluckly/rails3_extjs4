class Dimension < ActiveRecord::Base
  include MongoSync

  has_many :periods
  has_many :drivers

  attr_accessible :name, :summary

  validates :name, :presence => true, :uniqueness => true
end