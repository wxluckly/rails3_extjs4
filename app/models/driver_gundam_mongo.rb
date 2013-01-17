class DriverGundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :driver
  belongs_to :gundam

  field :_id, type: Integer

  # 建立关联
  after_create :add_relation
  def add_relation
    driver.tap {|d| d.add_to_set(:gundam_ids, gundam_id)}
    gundam.tap {|g| g.add_to_set(:driver_ids, driver_id)}
  end
  
  # 取消关联
  before_destroy :remove_relation
  def remove_relation
    driver.tap {|d| d.pull(:gundam_ids, gundam_id)}
    gundam.tap {|g| g.pull(:driver_ids, driver_id)}
  end
end