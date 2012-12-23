require_relative "collector/console"
require_relative "collector/queue"
require_relative "collector/runner"

module DataInsight
  module Collector
    def self.options
      {}
    end

    def self.messages(options)
      raise "override this"
    end

    def self.queue_name(options)
      raise "override this"
    end

    def self.queue_routing_key(options)
      raise "override this"
    end

    def self.handle_error(error)
    end
  end
end