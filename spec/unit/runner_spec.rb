# encoding: UTF-8

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
    queue.should_receive(:push) do |messages|
      messages.to_a.should == ['{"title":"this is a message"}']
    end

    runner = DataInsight::Collector::Runner.new
    runner.run(collector, queue)
  end

  it "should convert to json all the messages" do
    collector = TestCollector.new([{id: 1}, {id: 2}])
    queue = double(queue)
    queue.should_receive(:push) do |messages|
      messages.to_a.should == ['{"id":1}', '{"id":2}']
    end

    runner = DataInsight::Collector::Runner.new
    runner.run(collector, queue)
  end

  it "should escape unicode characters in messages" do
    collector = TestCollector.new([{title: "è"}])
    queue = double(queue)
    queue.should_receive(:push) do |messages|
      messages.to_a.should == ['{"title":"\u00e8"}']
    end

    runner = DataInsight::Collector::Runner.new
    runner.run(collector, queue)
  end

  it "should lazily evaluate the message list and send as soon as it receives" do
    counter = 0
    messages = Enumerator.new do |yielder|
      [{id: 1}, {id: 2}].each do |message|
        counter += 1
        yielder.yield(message)
      end
    end

    collector = TestCollector.new(messages)
    queue = double(queue)
    queue.should_receive(:push) do |messages|
      counter.should == 0
      messages.to_a
      counter.should == 2
    end
  
    runner = DataInsight::Collector::Runner.new
    runner.run(collector, queue)
  end

end