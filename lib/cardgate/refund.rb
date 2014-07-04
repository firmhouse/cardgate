module Cardgate

  class Refund

    attr_accessor :site_id, :referenced_transaction_id, :amount, :reason

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def default_params
      {
        refund: {
          site_id: @site_id,
          referenced_transaction_id: @referenced_transaction_id,
          amount: @amount,
          reason: @reason
        }
      }
    end

    def params
      default_params.deep_merge!(refund_params)
    end

    def refund_params
      {}
    end

    def initiate
      @response ||= response

      self
    end

    def transaction_id
      @response.body['refund']['transaction_id']
    end

    def api_refund_endpoint
      "/rest/v1/#{provider}/refund/"
    end

    private

    def response
      result = Cardgate::Gateway.connection.post do |req|
        req.url api_refund_endpoint
        req.headers['Accept'] = 'application/json'
        req.body = params
      end

      Cardgate::Response.new(result)
    end

  end

end
