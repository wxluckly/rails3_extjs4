class GundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :_id, type: Integer

  has_and_belongs_to_many :drivers
  has_and_belongs_to_many :forces
  belongs_to :period
  belongs_to :usage
  belongs_to :manufactory
  belongs_to :story

  scope :from_period, lambda{ |period_id|
    if period_id.present?
      where(period_id: period_id)
    else
      all
    end
  }
  scope :from_dimension, lambda{ |period_id, dimension_id|
    if period_id.blank? and dimension_id.present?
      where(:period_id.in => PeriodMongo.where(dimension_id: dimension_id.to_i).map(&:id))
    else
      all
    end
  }

  mount_uploader :avatar, GundamAvatarUploader
end
