# 预加载指定模块
require 'redis/objects'

# 自动加载文件
auto_required_paths = %W(lib app/caches app/validators app/workers)

auto_required_paths.each do |d|
  Dir["#{Rails.root}/#{d}/*.rb"].each {|p| require p}
end
