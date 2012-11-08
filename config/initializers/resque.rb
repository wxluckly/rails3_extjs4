require 'resque'

# 指定redis服务器
Resque.redis = Redis.new($conf[:redis][:server])
