require 'test_helper'

module CardgateTestCases

  class PaymentTestCases < Test::Unit::TestCase

    def stub_cardgate_connection(status, response)
      cardgate_connection do |stubs|
        stubs.post('/rest/v1/mistercash/payment/') { [status, {}, response] }
      end
    end

    def test_create_payment

      cardgate_connection = stub_cardgate_connection(201, CardgateFixtures::PAYMENT_SUCCESSFUL)
      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      payment = Cardgate::Payment.new({
        site_id: 5112,
        description: 'Nieuwe betaling',
        ip_address: '83.84.166.218',
        amount: 10000,
        ref: 'testorder9',
        currency: 'EUR',
        return_url: 'http://nu.nl',
        first_name: 'Michiel',
        last_name: 'Sikkes',
        email: 'michiel@firmhouse.com'
      })

      payment.provider = 'mistercash'
      payment.initiate

    end

    def test_raise_if_provider_not_set
      Cardgate::Gateway.merchant = 'a'
      Cardgate::Gateway.api_key = 'b'

      payment = Cardgate::Payment.new()
      payment.provider = nil

      assert_raises Cardgate::Exception do
        payment.initiate
      end
    end

  end

end
