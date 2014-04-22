module Cardgate

  class Response

    attr_reader :body

    def initialize(response)
      if response.body.nil?
        raise Cardgate::Exception, 'Got an empty response from API'
      elsif !response.status.between?(200, 299)
        raise Cardgate::Exception, "#{response.body["error"]["code"]}: #{response.body["error"]["message"]}"
      else
        @body = response.body
      end
    end

  end

end
