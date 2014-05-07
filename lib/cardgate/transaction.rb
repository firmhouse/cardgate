module Cardgate

  class Transaction

    attr_reader :transaction_id, :site_id, :site_name, :payment_method, :status, :timestamp, :currency, :amount, :ref,
                :first_name, :last_name, :company_name, :address, :city, :state, :postal_code, :country_code, :phone_number, :email

    def initialize(attributes = {})
      attributes.map do |attribute, value|
        if attribute == 'customer' && !value.nil?
          attributes['customer'].map do |attribute, value|
            set_variable_from_attribute(attribute, value)
          end
        else
          set_variable_from_attribute(attribute, value)
        end
      end
    end

    def successful?
      [200, 210].include?(self.status.to_i)
    end

    private

    def set_variable_from_attribute(attribute, value)
      instance_variable_set("@#{attribute}".to_sym, value)
    end

  end

end
