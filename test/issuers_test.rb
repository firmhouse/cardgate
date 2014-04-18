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

      issuer = issuers.first

      assert issuer.is_a? Cardgate::Ideal::Issuer
      assert_equal 121, issuer.id
      assert_equal 'Test Issuer', issuer.name
      assert_equal 'Short', issuer.list
    end

    def test_list_no_response
      cardgate_connection = stub_cardgate_connection(nil)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      assert_raises Cardgate::Exception do
        Cardgate::Ideal::Issuers.list
      end
    end

    def test_list_no_issuers
      cardgate_connection = stub_cardgate_connection(CardgateFixtures::ISSUERS_LIST_EMPTY)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      assert Cardgate::Ideal::Issuers.list.empty?
    end

  end

end
