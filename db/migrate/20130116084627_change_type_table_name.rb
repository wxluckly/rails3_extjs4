class ChangeTypeTableName < ActiveRecord::Migration
  def change
    rename_table :types, :usages
    rename_column :gundams, :type_id, :usage_id
  end
end