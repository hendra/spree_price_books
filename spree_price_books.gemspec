# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_price_books'
  s.version     = '3.1.1'
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

  s.add_dependency 'google_currency'
  s.add_dependency 'spree_core', '~> 3.1.1'
  s.add_dependency 'validates_timeliness', '~> 3.0'

  s.add_development_dependency 'rake', '< 11.0'
  s.add_development_dependency 'capybara', '~> 2.18'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot', '~> 4.8'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'pg', '~> 0.19'
  s.add_development_dependency 'rspec-rails',  '~> 3.4'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'sass-rails', '~> 5.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'timecop'
end
