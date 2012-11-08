# 全局配置类，使用 config/conf.yml
class Conf
  # 初始化时载入配置
  def initialize
    load_conf
  end
  
  # 转发调用
  def [](key)
    load_conf if ['development'].include?(Rails.env)
    @conf[key.to_sym]
  end
  
private
  
  # 载入配置文件
  def load_conf
    @conf = YAML.load_file(File.expand_path('../conf.yml', __FILE__))[Rails.env]
    symbolize_keys!(@conf)
  end
  
  def symbolize_keys!(obj)
    return unless obj.is_a?(Hash)
    
    obj.symbolize_keys!
    obj.each_value {|v| symbolize_keys!(v)}
  end
end
