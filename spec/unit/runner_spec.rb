require "spec_helper"

describe DataInsight::Collector::Runner do

  it "should print collected data to the console" do
    DataInsight::Collector.stub(:collector).and_return(TestCollector.new(:collected_data))
    DataInsight::Collector::Console.any_instance.should_receive(:push).with(:collected_data)

    DataInsight::Collector::Runner.new.print({})
  end

  it "should send collected data to a queue" do
    DataInsight::Collector.stub(:collector).and_return(TestCollector.new(:collected_data))
    DataInsight::Collector.stub(:queue_name).and_return(:destination_queue)
    DataInsight::Collector.stub(:queue_routing_key).and_return(:a_routing_key)

    queue = double("BunnyQueue")
    DataInsight::Collector::BunnyQueue.should_receive(:new).with(:destination_queue, :a_routing_key).and_return(queue)
    queue.should_receive(:push).with(:collected_data)

    DataInsight::Collector::Runner.new.broadcast({})
  end

end