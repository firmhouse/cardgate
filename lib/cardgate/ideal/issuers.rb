module Cardgate

  module Ideal

    class Issuers < Gateway

      def self.list
        find_all_from_api
      end

      private

      def self.find_all_from_api
        response = Cardgate::Gateway.connection.get do |req|
          req.url '/rest/v1/ideal/issuers/'
          req.headers['Accept'] = 'application/json'
        end

        raise Cardgate::Exception, 'Got empty response' if response.nil?

        issuers = response.body['issuers']

        raise Cardgate::Exception, 'No issuers retrieved' if issuers.blank?

        issuers.map do |issuer|
          Cardgate::Ideal::Issuer.new(issuer['id'], issuer['name'], issuer['list'])
        end
      end

    end

  end

end
