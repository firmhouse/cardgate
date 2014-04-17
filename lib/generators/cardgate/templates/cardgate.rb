unless Rails.env.production?
  Cardgate::Gateway.environment = :test
end

Cardgate::Gateway.merchant = ''
Cardgate::Gateway.api_key = ''
