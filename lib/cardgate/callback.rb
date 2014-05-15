module Cardgate

  class Callback

    attr_accessor :is_test, :transaction_id, :currency, :amount, :ref, :status, :hash_key, :hash

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def valid?
      hash_elements = [ @transaction_id, @currency, @amount, @ref, @status, @hash_key ]
      hash_elements.unshift 'TEST' if @is_test.to_i == 1

      Digest::MD5.hexdigest(hash_elements.join) == @hash
    end

    def response
      "#{@transaction_id}.#{@status}"
    end

    def successful?
      [200, 210].include?(@status.to_i)
    end

    def failed?
      [300, 301].include?(@status.to_i)
    end

    def recurring_failed?
      @status.to_i == 310
    end

    def refund?
      @status.to_i == 400
    end

  end

end
