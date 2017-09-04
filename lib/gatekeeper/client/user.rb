module Gatekeeper
  module Client
    class User < Base
      def initialize
        puts connection.inspect
      end
    end
  end
end
