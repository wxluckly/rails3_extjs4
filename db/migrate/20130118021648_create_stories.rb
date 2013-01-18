class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :gundam_id
      t.string :name
      t.text :summary
      t.timestamps
    end
  end
end