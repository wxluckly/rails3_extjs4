class CreateRawGundams < ActiveRecord::Migration
  def change
    create_table :raw_gundams do |t|
      t.string :period
      t.string :name    
      t.string :name_chs
      t.string :name_jp
      t.string :model
      t.string :usage
      t.string :force
      t.string :story
      t.string :manufactory
      t.string :specifications
      t.string :internal_environment
      t.string :measurement
      t.string :weight
      t.string :armor
      t.string :output
      t.string :propulsion
      t.string :acceleration
      t.string :special_equipped
      t.string :default_weapon
      t.string :selected_weapon
      t.string :hand_weapon
      t.string :ranged_weapon
      t.text :summary
      t.timestamps
    end
  end
end
