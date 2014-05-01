module Cardgate

  class Transactions

    def self.find(transaction_id)
      result = Cardgate::Gateway.connection.get do |req|
        req.url "/rest/v1/transactions/#{transaction_id}/"
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
