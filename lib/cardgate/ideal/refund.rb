module Cardgate

  module Ideal

    class Refund < Cardgate::Refund

      private

      def provider
        'ideal'
      end

    end

  end

end
