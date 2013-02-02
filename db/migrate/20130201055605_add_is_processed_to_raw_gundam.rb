class AddIsProcessedToRawGundam < ActiveRecord::Migration
  def change
    change_table :raw_gundams do |t|
      t.boolean :is_processed
    end
  end
end