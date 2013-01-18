class Driver < ActiveRecord::Base
  include MongoSync
  
  has_many :driver_gundams

  attr_accessible :name, :summary, :gundam_id

  validates :name, :presence => true, :uniqueness => { :scope => :dimension_id, :message => "should have only one name per dimension" }
end