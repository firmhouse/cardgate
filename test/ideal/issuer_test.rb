require 'test_helper'

module CardgateTestCases

  class IdealIssuerTestCases < Test::Unit::TestCase

    def test_eql

      issuer_1a = Cardgate::Ideal::Issuer.new(1, 'Name', 'Short')
      issuer_1b = Cardgate::Ideal::Issuer.new(1, 'Name', 'Short')
      issuer_2 = Cardgate::Ideal::Issuer.new(2, 'Name', 'Short')

      assert_equal issuer_1a, issuer_1a
      assert_equal issuer_1a, issuer_1b
      assert_not_equal issuer_1a, issuer_2

    end

  end

end
