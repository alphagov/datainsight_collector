module DataInsight
  module Collector
    class Runner

      def initialize

      end

      def self.print(options)
        Runner.new.run(collector(options), Console.new)
      end

      def self.broadcast(options)
        Runner.new.run(collector(options), queue(options))
      end

      def run(collector, destination)
        destination.push(collector.messages.map {|msg| msg.to_json(ascii_only: true)})
      end


      private

      def self.collector(options)
        Collector.collector(options)
      end

      def self.queue(options)
        BunnyQueue.new(Collector.queue_name(options), Collector.queue_routing_key(options))
      end

    end
  end
end