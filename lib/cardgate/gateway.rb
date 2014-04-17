module Cardgate

  class Gateway

    class << self
      attr_accessor :environment

      attr_accessor :merchant

      attr_accessor :api_key
    end

    self.environment = :test

    def self.is_test_environment?
      environment.to_sym == :test
    end

    def request_url
      if self.class.is_test_environment?
        Cardgate::TEST_URL
      else
        Cardgate::LIVE_URL
      end
    end

  end

end
