require "spec_helper"

describe DataInsight::Collector::Runner do

  it "should print collected data to the console" do
    runner = double("collector")

    DataInsight::Collector::Runner.stub(:new).and_return(runner)
    DataInsight::Collector.stub(:collector).and_return(:a_collector)

    runner.should_receive(:run).with(:a_collector, kind_of(DataInsight::Collector::Console))

    DataInsight::Collector::Runner.print({})
  end

  it "should send collected data to a queue" do
    runner = double("collector")

    DataInsight::Collector::Runner.stub(:new).and_return(runner)
    DataInsight::Collector.stub(:collector).and_return(:a_collector)
    DataInsight::Collector.stub(:queue_name)
    DataInsight::Collector.stub(:queue_routing_key)

    runner.should_receive(:run).with(:a_collector, kind_of(DataInsight::Collector::BunnyQueue))

    DataInsight::Collector::Runner.broadcast({})
  end

  it "should send a collected message to a destination in json format" do
    collector = TestCollector.new([{title: "this is a message"}])
    queue = double(queue)
    queue.should_receive(:push).with(["{\"title\":\"this is a message\"}"])

    runner = DataInsight::Collector::Runner.new
    runner.run(collector, queue)
  end

end