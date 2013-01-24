Feature: Collector

  Scenario: Collector configured incorrectly
    Given No collector configuration
    When I run `bundle exec collector print`
    Then the output should contain "Configuration not found. Please create a collector initializer at"
    And the output should contain "config/collector.rb"
    And the exit status should not be 0

    Given An empty collector configuration
    When I run `bundle exec collector print`
    Then the output should contain "Please override the method DataInsight::Collector.collector to return a collector of messages"
    And the exit status should not be 0
