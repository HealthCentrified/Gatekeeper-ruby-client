module Gatekeeper
  module Client
    class Base
      def connection
        Faraday.new(url: ENV['GATEKEEPER_HOST'])
      end
    end
  end
end
