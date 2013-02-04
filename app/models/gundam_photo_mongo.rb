class GundamPhotoMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer
  field :image, type: String

  belongs_to  :gundam

  mount_uploader :image, GundamPhotoUploader

  scope :verified, where(:is_verified => true)
  scope :unverified, where(:is_verified => false)
end
