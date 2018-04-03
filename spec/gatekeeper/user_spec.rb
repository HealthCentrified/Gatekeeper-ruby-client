require "spec_helper"

RSpec.describe Gatekeeper::Client::User do
  context "with a public OAuth client already existing" do
    before do
      @public_client = Gatekeeper::Client::OAuthClient.find(client_id: 'PublicClient',
                                                            username: 'testuser-hammock1',
                                                            password: 'password')
    end

    context "with an existing user with known credentials on an non-LDAP server" do
      it "should authenticate" do
        expect(@public_client.access_token).to_not be_nil
      end
    end

    context "when trying to get a list of users" do
      it "should give you a list of all users" do
        expect(@public_client.users).not_to be_empty
      end
    end

    context "when trying to get a list of users with a type of client" do
      it "should give you a list of users that are just clients" do
        clients = @public_client.users.clients
        expect(clients).not_to be_empty
        clients.each do |client|
          expect(client.has_scope?('client')).to be_truthy
        end
      end
    end

    context "when trying to find all users with permissions of client:testuser-hammock1" do
      it "should give you all users that have the right permissions" do
        clients = @public_client.users.have_access?('client:testuser-hammock1')
        expect(clients).not_to be_empty
        expect(clients.size).to equal(1)
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

  end

end
