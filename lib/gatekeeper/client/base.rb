require 'faraday'
require 'faraday_middleware'

module Gatekeeper
  module Client
    class Base
      class << self
        def connection
          Faraday.new(url: ENV['GATEKEEPER_HOST']) do |faraday| 
            faraday.response :logger
            faraday.request :json
            faraday.adapter Faraday.default_adapter
          end
        end
      end
    end
  end
end
