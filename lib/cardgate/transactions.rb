module Cardgate

  class Transactions

    attr_reader :id

    def initialize(id)
      @id = id
    end

    def find
      result = Cardgate::Gateway.connection.get do |req|
        req.url '/rest/v1/transactions/'
        req.headers['Accept'] = 'application/json'
      end

      response = Cardgate::Response.new(result)

      transaction = response.body['transaction']

      if !transaction.empty?
        Cardgate::Transaction.new(transaction)
      else
        raise Cardgate::Exception, 'Transaction was empty'
      end
    end

  end

end
