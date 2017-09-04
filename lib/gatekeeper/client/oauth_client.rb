module Gatekeeper
  module Client
    class OAuthClient < Base
      class << self
        def find(client_id: , client_secret: nil, username: nil, password: nil)
          payload = {client_id: client_id}
          if client_secret
            payload[:client_secret] = client_secret
            payload[:grant_type] = 'client_credentials'
          else
            payload[:grant_type] = 'password'
            payload[:username] = username
            payload[:password] = password
          end
          response = connection.post do |request|
            request.url '/tokens'
            request.headers['Content-Type'] = 'application/json'
            request.body = payload
          end
          body = JSON.parse(response.body)
          new(client_id, client_secret, body['access_token'])
        end
      end

      attr_reader :access_token

      def initialize(client_id, client_secret, access_token)
        @client_id = client_id
        @client_secret = client_secret
        @access_token = access_token
      end
    end
  end
end
