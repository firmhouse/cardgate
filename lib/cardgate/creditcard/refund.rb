module Cardgate

  module Creditcard

    class Refund < Cardgate::Refund

      attr_accessor :descriptor

      private

      def provider
        'creditcard'
      end

      def refund_params
        {
          refund: {
            descriptor: @descriptor
          }
        }
      end

    end

  end

end
