require 'rails/generators'

module Cardgate
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)
      desc 'This generator installs the cardgate initializer'

      def install
        copy_file 'cardgate.rb', 'config/initializers/cardgate.rb'
      end

    end
  end
end
