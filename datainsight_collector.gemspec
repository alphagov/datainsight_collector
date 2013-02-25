# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["GOV.UK Dev"]
  gem.email         = %w(govuk-dev@digital.cabinet-office.gov.uk)
  gem.description   = "helper for implementing Data Insight Collectors"
  gem.summary       = "helper for implementing Data Insight Collectors"
  gem.homepage      = "https://github.com/alphagov/datainsight_collector"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = [ "collector" ]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "datainsight_collector"
  gem.require_paths = %w(lib)
  gem.version       = "0.0.8"

  gem.add_dependency "bunny"
  gem.add_dependency "gli", "1.6.0"
  gem.add_dependency "datainsight_logging"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "aruba"
  gem.add_development_dependency "gemfury"
  gem.add_development_dependency "gem_publisher", "~> 1.2.0"
  gem.add_development_dependency "timecop"
end
