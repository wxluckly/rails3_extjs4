class Driver < ActiveRecord::Base
  include MongoSync
  
  has_many :driver_gundams
end
