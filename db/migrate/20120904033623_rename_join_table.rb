class RenameJoinTable < ActiveRecord::Migration
	def change
    rename_table :driver_gundams , :drivers_gundams
	end
end
