require "spec_helper"

RSpec.describe Gatekeeper::Client::User do
  context "with a public OAuth client already existing" do
    before do
      @public_client = Gatekeeper::Client::OAuthClient.find(client_id: 'PublicClient',
                                                            username: 'testuser',
                                                            password: 'password')
    end

    context "with an existing user with known credentials on an non-LDAP server" do
      it "should authenticate" do
        puts @public_client.inspect
        expect(@public_client.access_token).to_not be_nil
      end
    end
  end

  context "with a private OAuth client already existing" do
    before do
      @private_client = Gatekeeper::Client::OAuthClient.find(client_id: 'ClientCredentialsClient',
                                                             client_secret: 'credentials')
    end

    context "with a PostgreSQL backed user" do
      it "should authenticate" do
        expect(@private_client.access_token).to_not be_nil
      end
    end

=begin
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

=end
  end

end
