class AddGundamIdToRawGundam < ActiveRecord::Migration
  def change
    add_column :raw_gundams, :gundam_id, :integer
  end
end