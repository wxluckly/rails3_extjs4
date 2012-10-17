class Driver < ActiveRecord::Base

	has_and_belongs_to_many :gundams

	attr_accessible :name
  
end
