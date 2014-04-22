class CardgateFixtures

  ISSUERS_LIST = '{"issuers":[{"list":"Short", "name":"Test Issuer", "id":121}, {"list":"Short", "name":"Test Issuer 2", "id":151}, {"list":"Long", "name":"Test Issuer 3", "id":171}]}'
  ISSUERS_LIST_EMPTY = '{"issuers":[]}'

  PAYMENT_SUCCESSFUL = '{"payment":{"transaction_id":2307459, "issuer_auth_url":"https://gateway.cardgateplus.com/simulator/?return_url=https://www.stofzuigermarkt.nl"}}'
  PAYMENT_UNSUCCESSFUL = '{"error":{"message":"We encountered an internal error. Please try again later.", "code":"InternalServerError", "resource":"/rest/v1/ideal/payment/"}}'

end