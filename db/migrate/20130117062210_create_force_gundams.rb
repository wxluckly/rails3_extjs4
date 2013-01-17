class CreateForceGundams < ActiveRecord::Migration
  def change
    create_table :force_gundams do |t|
      t.integer :force_id
      t.integer :gundam_id
      t.timestamps
    end
  end
end
