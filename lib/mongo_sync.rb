# Mongo同步模型
module MongoSync
  extend ActiveSupport::Concern
  
  included do
    # 取对象的类名
    def mongo_class
      "#{self.class.name}Mongo".constantize
    end
    
    # 同步保存
    after_save :mongo_save
    def mongo_save
      mongo_class.find_or_initialize_by(id: id).update_attributes(attributes, without_protection: true)
    end
    
    # 同步删除
    after_destroy :mongo_destroy
    def mongo_destroy
      mongo.destroy
    end
    
    # 取对象的mongodb对象
    def mongo
      mongo_class.find(id)
    end
    
    module ClassMethods
      # 取类名
      def mongo
        "#{self.to_s}Mongo".constantize
      end
    end
  end
end
