class CreateManufactories < ActiveRecord::Migration
  def change
    create_table :manufactories do |t|
      t.integer :gundam_id
      t.string :name
      t.text :summary
      t.timestamps
    end
  end
end