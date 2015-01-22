require 'test_helper'

module CardgateTestCases

  class ClassMethodsTest < Test::Unit::TestCase

    def test_is_test_environment?
      Cardgate::Gateway.environment = :test

      assert Cardgate::Gateway.is_test_environment?
    end

    def test_is_not_test_environment?
      Cardgate::Gateway.environment = :live

      refute Cardgate::Gateway.is_test_environment?
    end

  end

  class GatewayTest < Test::Unit::TestCase

    def test_request_url_for_test
      Cardgate::Gateway.environment = :test

      assert_equal 'https://api-test.cardgate.com', Cardgate::Gateway.request_url
    end

    def test_request_url_for_live
      Cardgate::Gateway.environment = :live

      assert_equal 'https://api.cardgate.com', Cardgate::Gateway.request_url
    end

    def test_connection_raises
      assert_raises Cardgate::Exception do
        Cardgate::Gateway.connection
      end
    end

    def test_request_logger
      Cardgate::Gateway.request_logger = true

      assert_equal true, Cardgate::Gateway.request_logger
    end
  end

end