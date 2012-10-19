class AddIndex < ActiveRecord::Migration
  def change
    add_index(:gundams, [:model, :period_id], :unique => true, :name => 'by_model_period')
    add_index(:periods, [:year, :series], :unique => true, :name => 'by_year_series')
    add_index(:types, :name, :unique => true, :name => 'by_name')
    add_index(:drivers, :name, :unique => true, :name => 'by_name')
  end
end
