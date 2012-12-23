module DataInsight
  module Collector
    class Runner

      def initialize

      end

      def print(options)
        run(collector(options), console)
      end

      def broadcast(options)
        run(collector(options), queue(options))
      end


      private

      def run(collector, destination)
        destination.push(collector.messages)
      end

      def collector(options)
        Collector.collector(options)
      end

      def console
        Console.new
      end

      def queue(options)
        BunnyQueue.new(Collector.queue_name(options), Collector.queue_routing_key(options))
      end

    end
  end
end