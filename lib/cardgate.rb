if !defined?(Rails)
  require 'deep_merge'
end

require 'cardgate/callback'
require 'cardgate/constants'
require 'cardgate/exception'
require 'cardgate/gateway'
require 'cardgate/response'
require 'cardgate/transaction'
require 'cardgate/transactions'
require 'cardgate/payment'
require 'cardgate/refund'
require 'cardgate/version'

require 'cardgate/creditcard/creditcard'
require 'cardgate/ideal/ideal'
