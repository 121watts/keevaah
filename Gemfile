source 'https://rubygems.org'

ruby "2.1.2"

gem 'rails', '4.1.4'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'aws-sdk'
gem 'draper', '~> 1.3'
gem 'stripe'
gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'
gem 'pg'
gem 'aasm'
gem 'asset_sync'
gem 'kaminari'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'faker'


group :production, :staging do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
	gem 'binding_of_caller'
  gem 'bullet'
end

group :development, :test do
  gem 'spring-commands-rspec'
	gem 'rspec-rails'
	gem 'capybara'
	gem 'shoulda-matchers', require: false
	gem 'launchy'
end

group :test do
  gem 'simplecov', require: false
  gem 'nyan-cat-formatter'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
end

gem 'simple_form'

gem 'pry'

gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'jquery-turbolinks'
gem 'masonry-rails'
gem 'paperclip'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
