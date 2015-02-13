module Cardgate

  module Ideal

    class Issuer

      attr_accessor :id, :name, :list

      def initialize(id, name, list)
        @id = id
        @name = name
        @list = list
      end


      def ==(o)
        o.class == self.class && o.id == id
      end
      alias_method :eql?, :==
    end

  end

end
