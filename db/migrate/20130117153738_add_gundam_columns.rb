class AddGundamColumns < ActiveRecord::Migration
  def change
    change_table :gundams do |t|
      t.string :name_jp
      t.integer :story_id
      t.integer :manufactory_id
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
    end
  end
end
