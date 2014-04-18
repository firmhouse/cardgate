require 'test_helper'

module CardgateTestCases

  class ResponseTestCases < Test::Unit::TestCase

    def test_response_body_nil
      result = Faraday.new
      result.stubs(:body).returns(nil)

      assert_raises Cardgate::Exception do
        Cardgate::Response.new(result)
      end
    end

    def test_not_http_status_200
      result = Faraday.new
      result.stubs(:body).returns('error' => { code: 'test', message: 'test' })
      result.stubs(:status).returns(404)

      assert_raises Cardgate::Exception do
        Cardgate::Response.new(result)
      end
    end

    def test_response_with_body
      result = Faraday.new
      result.stubs(:body).returns('test')
      result.stubs(:status).returns(200)

      assert_nothing_raised do
        Cardgate::Response.new(result)
      end
    end

  end

end