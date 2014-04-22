module Cardgate

  class Payment

    attr_accessor :site_id, :issuer_id, :return_url, :ref, :amount, :currency,
                  :language, :ip_address, :first_name, :last_name, :company_name,
                  :address, :city, :state, :postal_code, :country_code, :phone_number, :email,
                  :description

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def default_params
      {
        payment: {
          site_id: @site_id,
          ref: @ref,
          amount: @amount
        }
      }
    end

    def initiate
      @response ||= response

      self
    end

    private

    def response
      result = Cardgate::Gateway.connection.post do |req|
        req.url '/rest/v1/ideal/payment/'
        req.headers['Accept'] = 'application/json'
        req.body = params
      end

      Cardgate::Response.new(result)
    end

  end

end
