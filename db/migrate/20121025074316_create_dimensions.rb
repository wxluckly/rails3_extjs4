class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.string :name     # 年代名称
      t.string :summary  # 简介
      t.timestamps
    end
  end
end
