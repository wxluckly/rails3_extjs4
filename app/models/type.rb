class Type < ActiveRecord::Base
  include MongoSync

  has_many :gundam

  attr_accessible :name

end
