module Gatekeeper
  module Client
    class User < Base
      attr_reader :access_token
      attr_reader :path, :conditions
      attr_writer :path, :conditions

      def clients(opts={})
        self.conditions['type'] = 'client'
        self
      end

      def initialize(access_token)
        @access_token = access_token
        self.path = '/users'
        self.conditions = {}
        self
      end

      def have_access?(scope)
        self.conditions['type'] = scope
        self
      end

      def method_missing(method, *args)
        execute.send(method, *args)
      end

      def empty?
        execute.empty?
      end

      def execute
        response = Gatekeeper::Client::Base.connection.get do |request|
          request.url path
          request.headers['Content-Type'] = 'application/json'
          request.headers['Authorization'] = 'Bearer ' + access_token
          conditions.each do |condition, condition_value|
            request.params[condition] = condition_value
          end
        end
        body = JSON.parse(response.body)
        body.map do |attributes|
          Gatekeeper::Models::User.new(attributes)
        end
      end
    end
  end
end
