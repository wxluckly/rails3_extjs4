class AddIsVerifiedToGundamPhotos < ActiveRecord::Migration
  def change
    change_table :gundam_photos do |t|
      t.boolean :is_verfied, default: false 
    end
  end
end