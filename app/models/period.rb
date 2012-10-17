class Period < ActiveRecord::Base

  has_many :gundams

  attr_accessible :year, :name, :series
 
end
