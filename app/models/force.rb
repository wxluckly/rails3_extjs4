class Force < ActiveRecord::Base
  has_and_belongs_to_many :gundams, join_table: "force_gundams"
end
