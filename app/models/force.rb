class Force < ActiveRecord::Base
  include MongoSync
  
  has_many :force_gundams

  attr_accessible :name, :summary, :gundam_id

  validates :name, :presence => true, :uniqueness => true
end