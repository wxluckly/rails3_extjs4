class DriverGundam < ActiveRecord::Base
  include MongoSync

  belongs_to :driver
  belongs_to :gundam
end
