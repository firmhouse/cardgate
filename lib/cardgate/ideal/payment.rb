module Cardgate

  module Ideal

    class Payment < Cardgate::Payment

      def params
        default_params.deep_merge!(payment_params)
      end

      def payment_url
        @response.body['payment']['issuer_auth_url']
      end

      def transaction_id
        @response.body['payment']['transaction_id']
      end

      private

      def payment_params
        params = {
          payment: {
            issuer_id: @issuer_id,
            return_url: @return_url,
            currency: @currency,
            language: @language,
            ip_address: @ip_address,
            description: @description
          }
        }

        customer_fields = %w(first_name last_name company_name address city state postal_code country_code phone_number email)

        customer_fields.each do |field|
          var = instance_variable_get("@#{field}")

          if !var.nil? && !var.empty?
            params[:payment][:customer] = {} if params[:payment][:customer].nil?
            params[:payment][:customer][field.to_sym] = var
          end
        end

        params
      end

    end

  end

end
