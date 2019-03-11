# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_price_books'
  s.version     = '3.2.1'
  s.summary     = 'Price books allowing flexible product pricing.'
  s.description = s.summary
  s.required_ruby_version = '>= 2.3.0'

  s.author    = 'Jeff Dutil'
  s.email     = 'JDutil@BurlingtonWebApps.com'
  s.homepage  = 'http://www.spreecommerce.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  version = '>= 3.1.0', '< 4.0'
  s.add_dependency 'spree_core', version

  s.add_dependency 'google_currency'
  s.add_dependency 'validates_timeliness'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'pg', '~> 0.19'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  # s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'timecop'
end
