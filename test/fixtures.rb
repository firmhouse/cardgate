class CardgateFixtures

  ISSUERS_LIST = '{"issuers":[{"list":"Short", "name":"Test Issuer", "id":121}, {"list":"Short", "name":"Test Issuer 2", "id":151}, {"list":"Long", "name":"Test Issuer 3", "id":171}]}'
  ISSUERS_LIST_EMPTY = '{"issuers":[]}'

  PAYMENT_SUCCESSFUL = '{"payment":{"transaction_id":2307459, "issuer_auth_url":"https://gateway.cardgateplus.com/simulator/?return_url=https://www.stofzuigermarkt.nl"}}'
  PAYMENT_UNSUCCESSFUL = '{"error":{"message":"We encountered an internal error. Please try again later.", "code":"InternalServerError", "resource":"/rest/v1/ideal/payment/"}}'

  TRANSACTION_WITHOUT_CUSTOMER = '{"transaction":{"status":200, "payment_method":"ideal", "timestamp":"2014-04-22T15:19:01", "site_id":5112, "currency":"EUR", "amount":100, "ref":"test4", "transaction_id":2307824, "customer":null}}'
  TRANSACTION_WITH_CUSTOMER = '{"transaction":{"status":200, "payment_method":"ideal", "timestamp":"2014-04-22T15:19:01", "site_id":5112, "currency":"EUR", "amount":100, "ref":"test4", "transaction_id":2307824, "customer":{"first_name":"Youri", "last_name":"van der Lans", "company_name":"ITflows", "address":"Coenecoop 750", "city":"Waddinxveen", "state":"Zuid-Holland", "postal_code":"2741 PW", "country_code":"NL", "phone_number":"1234567890", "email":"youri@itflows.nl"}}}'

end