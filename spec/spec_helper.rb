require 'rack/test'

require 'middleman-core'
require 'middleman-core/rack'
require 'middleman/image_optim'

Dir.glob(File.join(__dir__, 'support/**/*.rb')) {|f| require f }

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  config.include TestApplication, type: :feature
  config.include Rack::Test::Methods, type: :feature
end
