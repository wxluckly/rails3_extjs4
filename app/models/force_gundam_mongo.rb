class ForceGundamMongo
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :force
  belongs_to :gundam

  field :_id, type: Integer

  # 建立关联
  after_create :add_relation
  def add_relation
    force.tap {|f| f.add_to_set(:gundam_ids, gundam_id)}
    gundam.tap {|g| g.add_to_set(:force_ids, force_id)}
  end
  
  # 取消关联
  before_destroy :remove_relation
  def remove_relation
    force.tap {|f| f.pull(:gundam_ids, gundam_id)}
    gundam.tap {|g| g.pull(:force_ids, force_id)}
  end
end