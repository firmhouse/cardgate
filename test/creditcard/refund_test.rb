require 'test_helper'

module CardgateTestCases

  class CreditcardRefundTestCases < Test::Unit::TestCase

    def test_params
      refund = Cardgate::Creditcard::Refund.new({descriptor: 'Descriptor'})
      params = refund.params

      assert_equal 'Descriptor', params[:refund][:descriptor]
    end

  end

end
