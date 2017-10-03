module Gatekeeper
  module Client
    class OAuthClient < Base
      class << self
        def cache_backend=(cache)
          @cache = cache
        end

        def find(client_id: ENV['GATEKEEPER_CLIENT_ID'],
                 client_secret: ENV['GATEKEEPER_CLIENT_SECRET'],
                 username: nil,
                 password: nil)
          access_token = nil
          cached_client = get_cache(key: client_id)
          if cached_client
            cached_client
          else
            payload = generate_payload(client_id, client_secret, username, password)
            response = connection.post do |request|
              request.url '/tokens'
              request.headers['Content-Type'] = 'application/json'
              request.body = payload
            end
            body = JSON.parse(response.body)
            access_token = body['access_token']
            set_cache(key: client_id, value: access_token, expiry: body['expiry'])
          end
          # test the cache retrieval works
          access_token = get_cache(key: client_id, fallback: access_token)
          new(client_id, access_token)
        end

        # These are decent utility methods, move to Base?
        def get_cache(key: nil, **additional_args)
          fallback = additional_args[:fallback]
          value = @cache.get(key) if @cache
          value || fallback
        end

        def set_cache(key: nil, value: nil, expiry: nil)
          if expiry
            @cache.setex(key, expiry.to_i, value) if @cache
          else
            @cache.set(key, value) if @cache
          end
          value
        end

        def generate_payload(client_id, client_secret, username, password)
          payload = {client_id: client_id}
          if client_secret
            payload[:client_secret] = client_secret
            payload[:grant_type] = 'client_credentials'
          else
            payload[:grant_type] = 'password'
            payload[:username] = username
            payload[:password] = password
          end
          payload
        end
      end

      attr_reader :access_token

      def initialize(client_id, access_token)
        @client_id = client_id
        @access_token = access_token
      end
    end
  end
end
