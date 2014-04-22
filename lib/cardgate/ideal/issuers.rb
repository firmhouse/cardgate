module Cardgate

  module Ideal

    class Issuers

      def self.list
        find_all_from_api
      end

      private

      def self.find_all_from_api
        result = Cardgate::Gateway.connection.get do |req|
          req.url '/rest/v1/ideal/issuers/'
          req.headers['Accept'] = 'application/json'
        end

        response = Cardgate::Response.new(result)

        issuers = response.body['issuers']

        if !issuers.empty?
          issuers.map do |issuer|
            Cardgate::Ideal::Issuer.new(issuer['id'], issuer['name'], issuer['list'])
          end
        else
          []
        end
      end

    end

  end

end
