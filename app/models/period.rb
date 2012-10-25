class Period < ActiveRecord::Base
  include MongoSync

  belongs_to  :dimension
  has_many    :gundams
  
  attr_accessible :year, :name, :series

  validates :year, :uniqueness => { :scope => :series, :message => "should have only one year per series" }
 
end
