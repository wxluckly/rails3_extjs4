class AddIndex < ActiveRecord::Migration
  def change
    add_index(:gundams, [:model, :period_id], :unique => true)
    add_index(:periods, [:year, :series], :unique => true)
    add_index(:types, :name, :unique => true)
    add_index(:drivers, :name, :unique => true)
  end
end
