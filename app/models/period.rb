class Period < ActiveRecord::Base
  include MongoSync

  has_many :gundams

  attr_accessible :year, :name, :series
 
end
