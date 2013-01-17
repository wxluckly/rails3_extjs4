class Force < ActiveRecord::Base
  include MongoSync
  
  has_many :force_gundams
end
