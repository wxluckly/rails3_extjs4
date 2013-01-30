class AddIsVerifiedToGundamPhotos < ActiveRecord::Migration
  def change
    change_table :gundam_photos do |t|
      t.boolean :is_verified, default: false 
    end
  end
end