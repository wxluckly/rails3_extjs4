#source 'https://rubygems.org'
source 'http://ruby.taobao.org'

# basic
gem 'rails', '~> 3.2.13'
gem 'mysql2'
gem 'redis'

# dependence && functions are dependent on
gem 'will_paginate'
gem 'kaminari'
gem 'rails_config'
gem 'acts_as_list'
gem 'state_machine'
gem 'typhoeus'
gem 'rest-client'
gem "therubyracer"
gem 'bson_ext'

# resource
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem "less-rails"

# mongo
gem 'mongo'
gem 'mongoid'
# gem 'mongoid_location'
# gem 'will_paginate_mongoid'
# gem 'carrierwave-mongoid', require: 'carrierwave/mongoid' 

# cache system
gem 'redis-activesupport'
gem 'redis-objects'

# search
gem 'tire'

# 异步和定时任务
gem 'resque'
gem 'resque-scheduler'

# 文件和图片处理
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-aliyun'

# 用户登录
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth'
gem 'omniauth-weibo-oauth2'
gem 'weibo'
gem 'weibo2'
gem 'weibo2_plugins'

# 界面组件
gem 'jquery-rails', '2.0.2'
gem "twitter-bootstrap-rails"
gem 'will_paginate-bootstrap'

# 辅助控件
gem 'quiet_assets'  # 禁用assets log
gem 'nokogiri'
gem 'sitemap_generator'

#wiki
gem 'htmldiff'

#form
gem 'simple_form'
# gem "client_side_validations", '3.2.1'
# gem 'client_side_validations-simple_form', '2.0.1'

# 开发环境
group :development do
  gem 'thin'
  gem 'rails3-generators'
  gem 'spork', '>= 0.9.0'
  gem 'capistrano'
  gem 'pry'
  gem 'pry-nav'
  gem 'rack-mini-profiler'
end

# 开发测试环境共用
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'#, require: false  # 修复对model的preload
end
