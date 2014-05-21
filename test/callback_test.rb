require 'test_helper'
require 'digest/md5'

module CardgateTestCases

  class CallbackTestCases < Test::Unit::TestCase

    def new_callback_hash(status, test=1)
      elements = {
        is_test: test,
        transaction_id: 1,
        currency: 'EUR',
        amount: 1000,
        ref: '420-1234567890',
        status: status,
        hash_key: 'abcdefg'
      }

      string = "1EUR1000420-1234567890#{status}abcdefg"
      string = 'TEST' + string if test == 1

      elements[:hash] = Digest::MD5.hexdigest(string)

      elements
    end

    def test_valid_callback
      callback = Cardgate::Callback.new(new_callback_hash(200))

      assert callback.valid?

      callback = Cardgate::Callback.new(new_callback_hash(200, 0))

      assert callback.valid?
    end

    def test_invalid_callback
      callback = Cardgate::Callback.new({
        is_test: 0,
        transaction_id: 1,
        currency: 'EUR',
        amount: 1000,
        ref: '420-1234567890',
        status: 200,
        hash_key: 'abcdefg-----',
        hash: "1EUR1000420-1234567890200abcdefg"
      })

      refute callback.valid?
    end

    def test_response
      hash = new_callback_hash(200)
      callback = Cardgate::Callback.new(hash)

      assert_equal "#{hash[:transaction_id]}.#{hash[:status]}", callback.response
    end

    def test_successful_transaction
      callback = Cardgate::Callback.new(new_callback_hash(200))

      assert callback.successful?

      callback = Cardgate::Callback.new(new_callback_hash(210))

      assert callback.successful?
    end

    def test_failed_transaction
      callback = Cardgate::Callback.new(new_callback_hash(300))

      assert callback.failed?

      callback = Cardgate::Callback.new(new_callback_hash(301))

      assert callback.failed?
    end

    def test_recurring_transaction_failed
      callback = Cardgate::Callback.new(new_callback_hash(310))

      assert callback.recurring_failed?
    end

    def test_transaction_refunded
      callback = Cardgate::Callback.new(new_callback_hash(400))

      assert callback.refund?
    end

  end

end
