module Cardgate

  module Ideal

    class Issuer

      attr_accessor :id, :name, :list

      def initialize(id, name, list)
        @id = id
        @name = name
        @list = list
      end

    end

  end

end
