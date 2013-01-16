class CreateDrivers < ActiveRecord::Migration
	def change
		create_table :drivers do |t|
			t.string :name
      t.string :summary
			t.timestamps
		end
    add_index(:drivers, :name, :unique => true)
	end
end
