source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in devise-activeresource.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

gem "rails", "~> 5.2"
gem "omniauth", "~> 1.9"
gem "oauth2"
gem "omniauth-oauth2"
gem "rdoc"

gem "activemodel-serializers-xml", github: "rails/activemodel-serializers-xml"

gem "rails-controller-testing"

gem "responders", "~> 2.4"

group :test do
  gem 'byebug'
  gem "omniauth-facebook"
  gem "omniauth-openid"
  gem "timecop"
  gem "webrat", "0.7.3", require: false
  gem "mocha", "~> 1.1", require: false
end
