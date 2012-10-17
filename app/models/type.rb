class Type < ActiveRecord::Base

  has_many :gundam

  attr_accessible :name

end
