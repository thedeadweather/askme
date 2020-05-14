source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'jquery-rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'webpacker'
gem 'rails-i18n'
gem 'uglifier'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Use sqlite3 as the database for Active Record
  gem 'listen'
end

group :production do
  gem 'pg'
end
