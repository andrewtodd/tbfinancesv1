source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.1'
# Use mysql as the database for Active Record
#gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'

gem 'sass', '3.4.17'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'

# Need to downgrade coffee script source from 1.91 due to errors with windows
gem 'coffee-script-source', '1.8.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#ading bundle because I'm getting an error that my bundle version is wrong
#now heroku is giving me an error saying bundler is too old
gem 'bundler', '1.17.1'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'best_in_place', github: 'bernat/best_in_place'

gem 'prawn'
gem 'prawn-table'

# used for pagination
gem 'kaminari'

# used for authentication
gem 'devise'

#gem 'mysqltopostgres', git: "https://github.com/maxlapshin/mysql2postgres.git"

#gem 'mysqltopostgres'

gem 'pg', '1.2.3'
#gem 'pg'

gem 'rails_12factor', group: :production

ruby "2.7.2"