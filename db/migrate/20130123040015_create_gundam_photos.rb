class CreateGundamPhotos < ActiveRecord::Migration
  def change
    create_table :gundam_photos, :options => 'AUTO_INCREMENT = 10001' do |t|
      t.integer :gundam_id
      t.string  :image
      t.timestamps
    end
  end
end