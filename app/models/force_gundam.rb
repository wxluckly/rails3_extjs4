# coding: utf-8
class ForceGundam < ActiveRecord::Base
  include MongoSync

  belongs_to :force
  belongs_to :gundam
end