Mongoid.logger.level = Logger::INFO
Moped.logger.level = Logger::INFO

Mongoid.logger = Logger.new("#{Rails.root}/log/mongodb.log", 'weekly')
Moped.logger = Logger.new("#{Rails.root}/log/mongodb.log")
