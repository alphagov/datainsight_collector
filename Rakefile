require 'rspec/core/rake_task'
require "gem_publisher"
require "cucumber/rake/task"

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.rspec_opts = ["--format documentation"]
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

desc "publish gem on gemfury"
task :publish_gem do |task|
  gem = GemPublisher.publish_if_updated("datainsight_collector.gemspec", :gemfury, :as => 'govuk')
  puts "Published #{gem}" if gem
end

namespace :test do
  desc "Run all tests"
  task :all => [:spec, :features]
end

task :default => "test:all"