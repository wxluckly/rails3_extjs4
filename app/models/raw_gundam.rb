class RawGundam < ActiveRecord::Base
  attr_accessible :name, :name_chs, :model, :period, :name_jp, :story, :usage, :manufactory, :force, :period, :specifications, :internal_environment, :measurement, :weight, :armor, :output, :propulsion, :acceleration, :special_equipped, :default_weapon, :selected_weapon, :hand_weapon, :ranged_weapon
end