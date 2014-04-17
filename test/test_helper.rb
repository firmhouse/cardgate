ENV['RAILS_ENV'] = 'test'

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'cardgate'

# For generators
require 'rails/generators/test_case'
require 'generators/cardgate/install_generator'
