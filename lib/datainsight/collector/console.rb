require "json"

module DataInsight
  module Collector
    class Console

      def push(messages)
        puts messages.each(&:to_json)
      end

    end
  end
end