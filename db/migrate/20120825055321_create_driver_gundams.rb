class CreateDriverGundams < ActiveRecord::Migration
	def change
		create_table :driver_gundams do |t|
      t.integer :driver_id
      t.integer :gundam_id
			t.timestamps
		end
	end
end
