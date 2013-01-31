class GundamPhoto < ActiveRecord::Base
  include MongoSync

  attr_accessible :image

  belongs_to  :gundam

  validates :image, :presence => true

  mount_uploader :image, GundamPhotoUploader

  scope :verified, where(:is_verified => true)
  scope :unverified, where(:is_verified => false)

  # 解决mongo数据无法被同步更新的问题
  after_save do 
    mongo.update_attribute(:image, self.attributes["image"])
  end
  
end