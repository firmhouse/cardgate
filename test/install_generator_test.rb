require 'test_helper'

module CardgateTestCases

  class InstallGeneratorTest < Rails::Generators::TestCase
    destination File.join('tmp')
    setup :prepare_destination
    tests ::Cardgate::Generators::InstallGenerator

    test 'install cardgate initializer' do
      run_generator %w(Cardgate install)

      assert_file 'config/initializers/cardgate.rb'
    end
  end

end
