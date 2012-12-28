require "json"

module DataInsight
  module Collector
    class Console

      def push(messages)
        messages.each do |message|
          puts message.to_json
        end
      end
    end
  end
end