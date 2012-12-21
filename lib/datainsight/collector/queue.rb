module DataInsight
  module Collector
    class BunnyQueue

      def initialize(name, key)
        @name = name
        @key = key
      end

      def push(messages)
        Bunny.run(ENV['AMQP']) do |client|
          exchange = client.exchange(@name, :type => :topic)
          messages.each do |msg|
            logger.debug { "Pushing to queue message: #{msg}" }
            exchange.publish(msg.to_json, :key => @key)
          end
        end
      end

    end
  end
end