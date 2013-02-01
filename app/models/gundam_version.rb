class GundamVersion < ActiveRecord::Base

  attr_accessible :gundam_id, :user_id, :model, :name, :name_chs, :name_jp, :usage_id, :period_id, :story_id, :manufactory_id,
    :specifications, :internal_environment, :measurement, :weight, :armor, :output, :propulsion, :acceleration, :special_equipped,
    :default_weapon, :selected_weapon, :hand_weapon, :ranged_weapon, :summary

  belongs_to  :gundam
  belongs_to  :user
  belongs_to  :usage
  belongs_to  :period
  belongs_to  :story
  belongs_to  :manufactory

  validates_associated :gundam
  validate :not_all_nil

  before_save :clear_unchanged_column

  def version
    "#{id}-#{created_at.to_i}"
  end

  def not_all_nil
    (attribute_names - ["id", "gundam_id", "user_id", "created_at", "updated_at"]).each do |attr_name|
      return if gundam.send(attr_name) != send(attr_name)
    end
    (attribute_names - ["id", "gundam_id", "user_id", "created_at", "updated_at"]).each do |attr_name|
      errors.add(:attr_name, '不能所有属性都没有修改')
    end
  end

  def clear_unchanged_column
    (attribute_names - ["id", "gundam_id", "user_id", "created_at", "updated_at"]).each do |attr_name|
      send("#{attr_name}=",nil) if gundam.send(attr_name) == send(attr_name)
    end
  end

  def merge
    (attribute_names - ["id", "gundam_id", "user_id", "created_at", "updated_at"]).each do |attr_name|
      gundam.send("#{attr_name}=",send(attr_name)) unless send(attr_name).nil?
    end
    gundam.version_id = id
    gundam.save
  end
end
