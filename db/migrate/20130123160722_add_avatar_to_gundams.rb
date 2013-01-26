class AddAvatarToGundams < ActiveRecord::Migration
  def change
    change_table :gundams do |t|
      t.string :avatar
    end
  end
end
