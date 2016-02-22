source 'https://rubygems.org'

# Declare your gem's dependencies in authentication.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem 'rails-api'
gem 'active_model_serializers', git: 'https://github.com/rails-api/active_model_serializers.git'
gem 'friendly_id', '~> 5.1.0'
gem 'active_hash_relation'
gem 'pg'

group :test do
  gem 'minitest'
  gem 'purdytest'
end

group :test, :development do
  gem 'rack-test', require: 'rack/test'
  gem 'brakeman', require: false
  gem 'meta_request'
  gem 'annotate', '~> 2.7'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
end
