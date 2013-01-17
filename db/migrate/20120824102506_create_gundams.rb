class CreateGundams < ActiveRecord::Migration
	def change
		create_table :gundams do |t|
      t.string :series          # 年代
      t.string :series_name     # 年代名称
			t.string :name    
      t.string :name_chs
      t.string :model
      t.string :type_id         # 类型
      t.string :force           # 势力
			t.timestamps
		end
	end
end
