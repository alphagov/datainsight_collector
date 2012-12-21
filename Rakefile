require 'rspec/core/rake_task'
require "gem_publisher"

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.rspec_opts = ["--format documentation"]
end

desc "publish gem on gemfury"
task :publish_gem do |task|
  gem = GemPublisher.publish_if_updated("datainsight_collector.gemspec", :gemfury)
  puts "Published #{gem}" if gem
end

task :default => :spec