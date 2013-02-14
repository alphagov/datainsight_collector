require "timecop"

require_relative "../spec_helper"
require_relative "../../lib/datainsight/collector/message_builder"

describe DataInsight::Collector::MessageBuilder do
  it "should build a valid message" do
    now = DateTime.new(2012, 12, 12, 12)
    payload = {:foo => "bar"}
    Timecop.freeze(now) do
      builder = DataInsight::Collector::MessageBuilder.new("MyCollector")
      message = builder.build(payload)

      message.should == {
        :envelope => {
          :collected_at => now,
          :collector => "MyCollector"
        },
        :payload => payload
      }
    end
  end
end