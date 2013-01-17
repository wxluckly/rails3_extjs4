class CreateForces < ActiveRecord::Migration
  def change
    create_table :forces do |t|
      t.string :name
      t.string :summary
      t.timestamps
    end

    remove_column :gundams, :force
  end
end