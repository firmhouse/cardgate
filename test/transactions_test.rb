require 'test_helper'

module CardgateTestCases

  class TransactionsTestCases < Test::Unit::TestCase

    def stub_cardgate_connection
      cardgate_connection do |stubs|
        stubs.get('/rest/v1/transactions/2307824') { [200, {}, CardgateFixtures::TRANSACTION_WITHOUT_CUSTOMER] }
        stubs.get('/rest/v1/transactions/2307825') { [200, {}, CardgateFixtures::TRANSACTION_WITH_CUSTOMER] }
        stubs.get('/rest/v1/transactions/2307826') { [200, {}, nil] }
      end
    end

    def test_transaction_without_customer
      cardgate_connection = stub_cardgate_connection()

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      transaction = Cardgate::Transactions.find(2307824)

      assert transaction.is_a? Cardgate::Transaction

      assert_equal 200, transaction.status
      assert_nil transaction.first_name
      assert_equal 'ideal', transaction.payment_method
      assert_equal '2014-04-22T15:19:01', transaction.timestamp
      assert_equal 5112, transaction.site_id
      assert_equal 'EUR', transaction.currency
      assert_equal 100, transaction.amount
      assert_equal 'test4', transaction.ref
      assert_equal 2307824, transaction.transaction_id
    end

    def test_transaction_with_customer
      cardgate_connection = stub_cardgate_connection()

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      transaction = Cardgate::Transactions.find(2307825)

      assert_equal 'Youri', transaction.first_name
      assert_equal 'van der Lans', transaction.last_name
      assert_equal 'ITflows', transaction.company_name
      assert_equal 'Coenecoop 750', transaction.address
      assert_equal 'Waddinxveen', transaction.city
      assert_equal 'Zuid-Holland', transaction.state
      assert_equal '2741 PW', transaction.postal_code
      assert_equal 'NL', transaction.country_code
      assert_equal '1234567890', transaction.phone_number
      assert_equal 'youri@itflows.nl', transaction.email
    end

    def test_empty_transaction
      cardgate_connection = stub_cardgate_connection()

      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      assert_raises Cardgate::Exception do
        transaction = Cardgate::Transactions.find(2307826)
      end
    end

  end

end
