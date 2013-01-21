module Seamon
  module Instrumentation
    module Search
      module ControllerRuntime
        extend ActiveSupport::Concern
        
        protected
    
        attr_internal :search_runtime
    
        def process_action(action, *args)
          LogSubscriber.reset_runtime
          super
        end
    
        def cleanup_view_runtime
          search_rt_before_render = LogSubscriber.reset_runtime
          runtime = super
          search_rt_after_render = LogSubscriber.reset_runtime
          self.search_runtime = search_rt_before_render + search_rt_after_render
          runtime - search_rt_after_render
        end
    
        def append_info_to_payload(payload)
          super
          payload[:search_runtime] = search_runtime
        end
    
        module ClassMethods
          def log_process_action(payload)
            messages, search_runtime = super, payload[:search_runtime]
            if search_runtime
              runtime = search_runtime.to_f
              color = if runtime < 100
                "\e[32m"
              elsif runtime < 200
                "\e[33m"
              else
                "\e[31m"
              end
              messages << ("Search: \e[1m#{color}%.1f\e[0m ms" % runtime)
            end
            messages
          end
        end
      end
    
      class LogSubscriber < ActiveSupport::LogSubscriber
        RUNTIME_KEY = 'seamon_search_runtime'
      
        def self.runtime=(value)
          Thread.current[RUNTIME_KEY] = value
        end
      
        def self.runtime
          Thread.current[RUNTIME_KEY] ||= 0
        end
      
        def self.reset_runtime
          rt, self.runtime = runtime, 0
          rt
        end
      
        def search(event)
          self.class.runtime += event.duration
        end
      end
    end
  end
end

Seamon::Instrumentation::Search::LogSubscriber.attach_to :seamon
