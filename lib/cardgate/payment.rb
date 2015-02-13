module Cardgate

  class Payment

    attr_accessor :site_id, :return_url, :control_url, :ref, :amount, :currency,
                  :language, :ip_address, :first_name, :last_name, :company_name,
                  :address, :city, :state, :postal_code, :country_code, :phone_number, :email,
                  :description, :provider

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end
    end

    def default_params
      default_params = {
        payment: {
          site_id: @site_id,
          currency: @currency,
          ref: @ref,
          return_url: @return_url,
          control_url: @control_url,
          currency: @currency,
          language: @language,
          ip_address: @ip_address,
          description: @description,
          amount: @amount
        }
      }

      customer_fields = %w(first_name last_name company_name address city state postal_code country_code phone_number email)

      customer_fields.each do |field|
        var = instance_variable_get("@#{field}")

        if !var.nil? && !var.empty?
          default_params[:payment][:customer] = {} if default_params[:payment][:customer].nil?
          default_params[:payment][:customer][field.to_sym] = var
        end
      end

      return default_params
    end

    def initiate
      @response ||= response

      self
    end

    def payment_url
      @response.body['payment']['issuer_auth_url']
    end

    def transaction_id
      @response.body['payment']['transaction_id']
    end

    def params
      default_params.deep_merge!(payment_params)
    end

    def payment_params
      {}
    end

    def api_payment_endpoint
      "/rest/v1/#{provider}/payment/"
    end

    def provider
      @provider or raise Cardgate::Exception.new('Provider not set for Payment')
    end

    private

    def response
      result = Cardgate::Gateway.connection.post do |req|
        req.url api_payment_endpoint
        req.headers['Accept'] = 'application/json'
        req.body = params
      end

      Cardgate::Response.new(result)
    end

  end

end
