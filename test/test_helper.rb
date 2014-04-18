require 'test/unit'
require 'mocha/test_unit'
require 'fixtures'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'cardgate'

def cardgate_connection
  @connection ||= Faraday.new do |faraday|
    faraday.response :json

    faraday.adapter :test do |stubs|
      yield(stubs)
    end 
  end
end
