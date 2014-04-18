ENV['RAILS_ENV'] = 'test'

require 'test/unit'
require 'faraday'
require 'fixtures'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'cardgate'

# For generators
require 'rails/generators/test_case'
require 'generators/cardgate/install_generator'

def cardgate_connection
  @connection ||= Faraday.new do |faraday|
    faraday.response :json

    faraday.adapter :test do |stubs|
      yield(stubs)
    end 
  end
end
