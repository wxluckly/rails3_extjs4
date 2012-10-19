class Gundam < ActiveRecord::Base
  include MongoSync

	has_and_belongs_to_many :drivers
  belongs_to :period
  belongs_to :type
  
	attr_accessible :name, :name_chs, :model, :period_id, :type_id, :period, :type
  
  validates :model, :uniqueness => { :scope => :period_id, :message => "should have only one model per period" }

end
