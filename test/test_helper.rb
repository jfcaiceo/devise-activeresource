# # Configure Rails Environment
# ENV["RAILS_ENV"] = "test"

# require_relative "../test/dummy/config/environment"
# ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
# require "rails/test_help"

# # Filter out the backtrace from minitest while preserving the one from other libraries.
# Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# require "rails/test_unit/reporter"
# Rails::TestUnitReporter.executable = 'bin/test'

# # Load fixtures from the engine
# if ActiveSupport::TestCase.respond_to?(:fixture_path=)
#   ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
#   ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
#   ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
#   ActiveSupport::TestCase.fixtures :all
# end

ENV["RAILS_ENV"] = "test"
DEVISE_ORM = (ENV["DEVISE_ORM"] || :active_resource).to_sym
DEVISE_PATH = ENV['DEVISE_PATH']

puts "\n==> Devise.orm = #{DEVISE_ORM.inspect}"

require 'activeresource'
require "rails_app/config/environment"
require "rails/test_help"
require "orm/#{DEVISE_ORM}"

require 'byebug'

ActiveSupport.test_order = :sorted

I18n.load_path << "#{DEVISE_PATH}/test/support/locale/en.yml"

require 'mocha/setup'
require 'timecop'
require 'webrat'
Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

# Add support to load paths so we can overwrite broken webrat setup
$:.unshift "#{DEVISE_PATH}/test/support"
Dir["#{DEVISE_PATH}/test/support/**/*.rb"].each { |f| require f }

# For generators
require "rails/generators/test_case"
require "generators/devise/install_generator"
require "generators/devise/views_generator"
require "generators/devise/controllers_generator"
