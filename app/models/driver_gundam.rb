# coding: utf-8
class DriverGundam < ActiveRecord::Base
  include MongoSync

  belongs_to :driver
  belongs_to :gundam
end
