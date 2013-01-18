class Dimension < ActiveRecord::Base
  include MongoSync

  has_many :periods

  validates :name, :presence => true, :uniqueness => true
end