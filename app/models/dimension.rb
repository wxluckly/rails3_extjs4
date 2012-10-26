class Dimension < ActiveRecord::Base
  include MongoSync

  has_many :periods

  validates :name, :uniqueness => true
end
