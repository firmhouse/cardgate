require 'test_helper'

module CardgateTestCases

  class TransactionTestCases < Test::Unit::TestCase

    def test_successful
      transaction = Cardgate::Transaction.new({status: 200})

      assert transaction.successful?

      transaction = Cardgate::Transaction.new({status: 210})

      assert transaction.successful?
    end

    def test_unsuccessful
      transaction = Cardgate::Transaction.new({status: 100})

      refute transaction.successful?

      transaction = Cardgate::Transaction.new({status: 300})

      refute transaction.successful?
    end

  end

end
