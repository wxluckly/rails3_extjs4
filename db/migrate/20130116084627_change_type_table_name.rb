class ChangeTypeTableName < ActiveRecord::Migration
  def change
    rename_table :types, :usages
  end
end
