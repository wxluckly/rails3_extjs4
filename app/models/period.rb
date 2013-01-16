class Period < ActiveRecord::Base
  include MongoSync

  belongs_to  :dimension
  has_many    :gundams

  validates :year, :uniqueness => { :scope => :dimension_id, :message => "should have only one year per series" }, :if => "year.present?"
end
