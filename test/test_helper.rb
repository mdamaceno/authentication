# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../test/dummy/db/migrate', __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'purdytest'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, 'test/factories/**/*.rb')].each { |f| require f }

# Load support files
Dir[File.join(ENGINE_RAILS_ROOT, 'test/support/**/*.rb')].each { |f| require f }

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include JSONParsed

  def pending
    raise 'Waiting for a code...'
  end
end

Purdytest.configure do |io|
  io.pass = :green
  io.fail = :red
  io.error = :yellow
  io.skip = :white
end
