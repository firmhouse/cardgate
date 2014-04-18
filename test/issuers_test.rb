require 'test_helper'

module CardgateTestCases

  class IdealIssuersTestCases < Test::Unit::TestCase

    def stub_cardgate_connection(response)
      cardgate_connection do |stubs|
        stubs.get('/rest/v1/ideal/issuers/') { [200, {}, response] }
      end
    end

    def test_list_returns_issuers
      cardgate_connection = stub_cardgate_connection(CardgateFixtures::ISSUERS_LIST)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      issuers = Cardgate::Ideal::Issuers.list

      assert issuers.first.is_a? Cardgate::Ideal::Issuer
    end

    def test_list_no_response
      cardgate_connection = stub_cardgate_connection(nil)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      assert_raises Cardgate::Exception do
        Cardgate::Ideal::Issuers.list
      end
    end

    def test_list_no_response
      cardgate_connection = stub_cardgate_connection(CardgateFixtures::ISSUERS_LIST_EMPTY)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      assert_raises Cardgate::Exception do
        Cardgate::Ideal::Issuers.list
      end
    end

  end

end
