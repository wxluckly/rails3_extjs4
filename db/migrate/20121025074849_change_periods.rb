class ChangePeriods < ActiveRecord::Migration
  def change
    change_table :periods do |t|
      t.remove  :series
      t.integer :dimension_id
    end
  end
end
