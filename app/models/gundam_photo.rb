class GundamPhoto < ActiveRecord::Base
  attr_accessible :image

  mount_uploader :image, GundamPhotoUploader
end
