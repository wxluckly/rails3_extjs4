class Dimension < ActiveRecord::Base
  include MongoSync

  has_many :periods

  attr_accessible :name, :summary
  
end
