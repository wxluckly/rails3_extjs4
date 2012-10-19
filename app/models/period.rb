class Period < ActiveRecord::Base
  include MongoSync

  has_many :gundams

  attr_accessible :year, :name, :series

  validates :year, :uniqueness => { :scope => :series, :message => "should have only one year per series" }
 
end
