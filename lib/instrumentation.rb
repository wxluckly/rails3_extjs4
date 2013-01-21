require 'instrumentation/rails'
require 'instrumentation/mongo'
require 'instrumentation/redis'
require 'instrumentation/api'
require 'instrumentation/search'

ActiveSupport.on_load(:action_controller) do
  include Seamon::Instrumentation::Mongo::ControllerRuntime
  include Seamon::Instrumentation::Redis::ControllerRuntime
  include Seamon::Instrumentation::Api::ControllerRuntime
  include Seamon::Instrumentation::Search::ControllerRuntime
end
