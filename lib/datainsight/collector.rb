require_relative "collector/console"
require_relative "collector/queue"
require_relative "collector/runner"

module DataInsight
  module Collector
    def self.options
      {}
    end

    def self.collector(options)
      raise "Please override the method DataInsight::Collector.collector to return a collector of messages"
    end

    def self.queue_name(options)
      raise "Please override the method DataInsight::Collector.queue_name to return the name of the destination queue"
    end

    def self.queue_routing_key(options)
      raise "Please override the method DataInsight::Collector.queue_routing_key to return the routing key for messages pushed to the queue"
    end

    def self.handle_error(error)
    end
  end
end