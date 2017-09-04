require "spec_helper"

RSpec.describe Gatekeeper::Client::User do
  context "with a public OAuth client already existing" do
    before do
      @public_client = Gatekeeper::Client::OAuthClient.find(client_id: 'PublicClient')
      @username = 'testuser'
      @password = 'password'
    end

    context "with an existing user with known credentials on an LDAP server" do
      expect(@public_client.users.authenticate(username: @username, password: @password)).to be(true)
    end
  end

  context "with a private OAuth client already existing" do
    before do
      @private_client = Gatekeeper::Client::OAuthClient.find(client_id: 'ClientCredentialsClient',
                                                             client_secret: 'credentials')
    end

    context "with a PostgreSQL backed user" do
      before do
      end
      it "can authenticate when given the right username and password" do
        pending
      end
      it "fails authentication when the username and password do not match" do
        pending
      end
    end

    context "with an LDAP backed user" do
      before do
      end
      it "can authenticate when given the right username and password" do
        pending
      end
      it "fails authentication when the username and password do not match" do
        pending
      end
    end
  end

end
