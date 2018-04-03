module Gatekeeper
  module Models
    class User
      attr_reader :username, :phone_number, :forgot_password_token, :scope
      def initialize(params)
        @username = params['username']
        @phone_number = params['phone_number']
        @forgot_password_token = params['forgot_password_token']
        @scope = params['scope']
      end

      def has_scope?(check_scope)
        scope.split(' ').include?(check_scope)
      end

      class << self
        def have_access(check_scope)
          
        end
      end
    end
  end
end
