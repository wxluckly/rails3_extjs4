class Type < ActiveRecord::Base
  include MongoSync

  has_many :gundam

  validates :name, :uniqueness => true
end
