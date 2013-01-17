class Driver < ActiveRecord::Base
  has_and_belongs_to_many :gundams, join_table: "driver_gundams"
end
