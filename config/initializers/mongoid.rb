Mongoid.configure do |config|
  config.logger = Logger.new("#{Rails.root}/log/mongodb.log", 'weekly')  # .tap {|logger| logger.level = Logger::INFO}
  config.use_activesupport_time_zone = true
end
