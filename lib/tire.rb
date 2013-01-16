module Tire::Model::Search::InstanceMethods
  # 重定义该方法，实现以下3个需求：
  # 1. 不再排除id和type
  # 2. 不再排除mapping以外的其它字段，可覆盖指定字段索引定义
  # 3. 使用JSON.generate提高效率
  def to_indexed_json
    if instance.class.tire.mapping.empty?
      # Reject the id and type keys
      # instance.to_hash.reject {|key,_| key.to_s == 'id' || key.to_s == 'type' }.to_json
      # 替换上述被注释的语句
      JSON.generate instance.as_json
    else
      mapping = instance.class.tire.mapping
      # Reject keys not declared in mapping
      # hash = instance.to_hash.reject { |key, value| ! mapping.keys.map(&:to_s).include?(key.to_s) }
      # 替换上述被注释的语句
      hash = instance.to_hash

      # Evalute the `:as` options
      mapping.each do |key, options|
        case options[:as]
          when String
            hash[key] = instance.instance_eval(options[:as])
          when Proc
            hash[key] = instance.instance_eval(&options[:as])
          else
            hash[key] = options[:as]
        end if options[:as]
      end

      JSON.generate hash
    end
  end
end

class Tire::Index
  # 因原始的import方法对于循环的判断与优化后的分页有冲突，故全部重写
  def import(klass_or_collection, options={})
    case
      when method = options.delete(:method)
        # 取最大id作为total
        options = {page: 1, per_page: 10000}.merge options.update(method: :paginate_by_id, total: klass_or_collection.select(:id).last.id)
        
        # 根据id进行分页和索引
        while (options[:page] - 1) * options[:per_page] + 1 <= options[:total]
          documents = klass_or_collection.send(options[:method].to_sym, options)
          
          documents = yield documents if block_given?
          bulk_store documents, options if documents.to_a.length > 0

          options[:page] += 1
        end
      
      # 以下为原始语句，未改动
      when klass_or_collection.respond_to?(:map)
        documents = block_given? ? yield(klass_or_collection) : klass_or_collection
        bulk_store documents, options

      else
        raise ArgumentError, "Please pass either an Enumerable compatible class, or a collection object" +
                             "with a method for fetching records in batches (such as 'paginate')"
    end
  end
end

module WillPaginate::ActiveRecord::Pagination
  # 根据id进行分页，只计算id偏移量，并以最大id为总数
  # 因为在大数据量下耗时太长，所以不使用offset和limit进行实际偏移计算
  def paginate_by_id(options)
    page, per_page, total = options[:page], options[:per_page], options[:total]
    
    find_by_sql("SELECT * FROM #{table_name} WHERE id BETWEEN \
                   #{(page - 1) * per_page + 1} AND #{[page * per_page, total].min}")
  end
end
