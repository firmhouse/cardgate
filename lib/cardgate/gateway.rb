require 'faraday_middleware'

module Cardgate

  class Gateway

    class << self
      attr_accessor :environment, :merchant, :api_key, :request_logger
    end

    def self.is_test_environment?
      self.environment == :test
    end

    def self.request_url
      if self.is_test_environment?
        Cardgate::TEST_URL
      else
        Cardgate::LIVE_URL
      end
    end

    def self.connection
      raise Cardgate::Exception, 'Merchant and/or API key not set' if !self.merchant || !self.api_key

      Faraday.new(url: self.request_url, ssl: { verify: !is_test_environment? } ) do |faraday|
        faraday.request  :json
        faraday.response :json
        faraday.response :logger if request_logger == true
        faraday.adapter  Faraday.default_adapter
        faraday.basic_auth self.merchant, self.api_key
      end
    end

  end

end
