class RemoveRawGundamIdFromGuandam < ActiveRecord::Migration
  def change
    remove_column :gundams, :raw_gundam_id
  end
end
