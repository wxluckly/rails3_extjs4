class RemoveUselessColumn < ActiveRecord::Migration
	def change
    remove_column :gundams, :series
    remove_column :gundams, :series_name
    add_column :gundams, :period_id, :integer
	end
end
