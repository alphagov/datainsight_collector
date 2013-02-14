module DataInsight
  module Collector
    class MessageBuilder
      def initialize(collector_name)
        @collector_name = collector_name
      end

      def build(payload)
        {
          :envelope => {
            :collector => @collector_name,
            :collected_at => DateTime.now
          },
          :payload => payload
        }
      end
    end
  end
end