require 'test_helper'

module CardgateTestCases

  class IdealPaymentTestCases < Test::Unit::TestCase

    def stub_cardgate_connection(status, response)
      cardgate_connection do |stubs|
        stubs.post('/rest/v1/ideal/payment/') { [status, {}, response] }
      end
    end

    def new_payment_attributes_hash
      {
        site_id: 1,
        issuer_id: 1,
        return_url: 'https://stofzuigermarkt.nl',
        ref: 'transaction-reference',
        amount: 100,
        currency: 'EUR',
        ip_address: '127.0.0.1',
        description: 'test'
      }
    end

    def test_successful_payment
      cardgate_connection = stub_cardgate_connection(201, CardgateFixtures::PAYMENT_SUCCESSFUL)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      payment_attributes = new_payment_attributes_hash

      payment = Cardgate::Ideal::Payment.new(payment_attributes)
      payment.initiate

      assert_equal 'https://gateway.cardgateplus.com/simulator/?return_url=https://www.stofzuigermarkt.nl', payment.payment_url
      assert_equal 2307459, payment.transaction_id
    end

    def test_unsuccessful_payment
      cardgate_connection = stub_cardgate_connection(500, CardgateFixtures::PAYMENT_UNSUCCESSFUL)

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      payment_attributes = new_payment_attributes_hash

      payment = Cardgate::Ideal::Payment.new(payment_attributes)

      assert_raises Cardgate::Exception do
        payment.initiate
      end
    end

    def test_params
      payment_attributes = new_payment_attributes_hash
      customer_attributes = {
        first_name: 'Youri',
        last_name: 'van der Lans',
        company_name: 'ITflows',
        address: 'Coenecoop 750',
        city: 'Waddinxveen',
        state: 'Zuid-Holland',
        postal_code: '2741 PW',
        country_code: 'NL',
        phone_number: '1234567890',
        email: 'youri@itflows.nl'
      }

      payment_attributes.merge!(customer_attributes)

      payment = Cardgate::Ideal::Payment.new(payment_attributes)
      params = payment.params

      assert_equal 1, params[:payment][:site_id]
      assert_equal 1, params[:payment][:issuer_id]
      assert_equal 'https://stofzuigermarkt.nl', params[:payment][:return_url]
      assert_equal 'transaction-reference', params[:payment][:ref]
      assert_equal 100, params[:payment][:amount]
      assert_equal 'EUR', params[:payment][:currency]
      assert_equal '127.0.0.1', params[:payment][:ip_address]
      assert_equal 'test', params[:payment][:description]

      assert_not_nil params[:payment][:customer]

      assert_equal 'Youri', params[:payment][:customer][:first_name]
      assert_equal 'van der Lans', params[:payment][:customer][:last_name]
      assert_equal 'ITflows', params[:payment][:customer][:company_name]
      assert_equal 'Coenecoop 750', params[:payment][:customer][:address]
      assert_equal 'Waddinxveen', params[:payment][:customer][:city]
      assert_equal 'Zuid-Holland', params[:payment][:customer][:state]
      assert_equal '2741 PW', params[:payment][:customer][:postal_code]
      assert_equal 'NL', params[:payment][:customer][:country_code]
      assert_equal '1234567890', params[:payment][:customer][:phone_number]
      assert_equal 'youri@itflows.nl', params[:payment][:customer][:email]
    end

    def test_empty_customer_params
      payment_attributes = new_payment_attributes_hash

      payment = Cardgate::Ideal::Payment.new(payment_attributes)
      params = payment.params

      assert_nil params[:payment][:customer]
    end

  end

end
