class CreateGundamVersions < ActiveRecord::Migration
  def change
    create_table :gundam_versions do |t|
      t.belongs_to  :gundam
      t.belongs_to  :user
      t.string   :model
      t.string   :name
      t.string   :name_chs
      t.string   :name_jp
      t.belongs_to  :usage
      t.belongs_to  :period
      t.belongs_to  :story
      t.belongs_to  :manufactory
      t.string   :specifications
      t.string   :internal_environment
      t.string   :measurement
      t.string   :weight
      t.string   :armor
      t.string   :output
      t.string   :propulsion
      t.string   :acceleration
      t.string   :special_equipped
      t.string   :default_weapon
      t.string   :selected_weapon
      t.string   :hand_weapon
      t.string   :ranged_weapon
      t.text     :summary
      t.string   :avatar

      t.timestamps
    end

    add_column :gundams, :version, :integer
  end
end
