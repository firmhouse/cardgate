require 'test_helper'

module CardgateTestCases

  class IdealRefundTestCases < Test::Unit::TestCase

    def stub_cardgate_connection(status, response)
      cardgate_connection do |stubs|
        stubs.post('/rest/v1/ideal/refund/') { [status, {}, response] }
      end
    end

    def new_refund_attributes_hash
      {
        site_id: 1,
        referenced_transaction_id: 2307831,
        amount: 100
      }
    end

    def test_successful_refund
      cardgate_connection = stub_cardgate_connection(201, CardgateFixtures::REFUND_SUCCESSFUL)
      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      refund = Cardgate::Ideal::Refund.new(new_refund_attributes_hash)
      refund.initiate

      assert_equal 2307831, refund.transaction_id
    end

    def test_unsuccessful_refund
      cardgate_connection = stub_cardgate_connection(500, CardgateFixtures::REFUND_UNSUCCESSFUL)
      Cardgate::Gateway.stubs(:connection).returns(cardgate_connection)

      refund = Cardgate::Ideal::Refund.new(new_refund_attributes_hash)

      assert_raises Cardgate::Exception do
        refund.initiate
      end
    end

    def test_params
      refund_attributes = new_refund_attributes_hash
      refund_attributes[:reason] = 'Double payed!'

      refund = Cardgate::Ideal::Refund.new(refund_attributes)
      params = refund.params

      assert_equal 1, params[:refund][:site_id]
      assert_equal 2307831, params[:refund][:referenced_transaction_id]
      assert_equal 100, params[:refund][:amount]
      assert_equal 'Double payed!', params[:refund][:reason]
    end

  end

end
