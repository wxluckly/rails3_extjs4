class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :series   # 系列
      t.string :name     # 年代别名
      t.string :year     # 年代
      t.text :summary  # 简介
      t.timestamps
    end
  end
end
