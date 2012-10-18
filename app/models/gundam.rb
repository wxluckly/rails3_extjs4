class Gundam < ActiveRecord::Base
  include MongoSync

	has_and_belongs_to_many :drivers
  belongs_to :period
  belongs_to :type
  
	attr_accessible :name, :name_chs, :model, :period_id, :type_id
end
