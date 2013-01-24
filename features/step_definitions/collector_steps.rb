Given /^An empty collector configuration$/ do
  write_file("config/collector.rb", "")
end

Given /^No collector configuration$/ do
  #remove_file "config/collector.rb"
end
