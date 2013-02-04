class ChangeGundamTableUsageIdType < ActiveRecord::Migration
  def change
    remove_column :gundams, :usage_id
    add_column :gundams, :usage_id, :integer
    add_column :gundams, :raw_gundam_id, :integer
  end
end