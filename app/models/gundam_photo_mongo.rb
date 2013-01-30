class GundamPhotoMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer
  field :image, type: String

  belongs_to  :gundam

  mount_uploader :image, GundamPhotoUploader

  scope :verfied, where(:is_verfied => true)
end
