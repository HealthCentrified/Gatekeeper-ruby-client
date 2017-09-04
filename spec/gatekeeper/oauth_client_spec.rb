require "spec_helper"

RSpec.describe Gatekeeper::Client::OAuthClient do
  context "with a public and a private OAuth client already existing" do
    before do
      @private_client = Gatekeeper::Client::OAuthClient.find(client_id: 'ClientCredentialsClient',
                                                        client_secret: 'credentials')
      @public_client = Gatekeeper::Client::OAuthClient.find(client_id: 'PublicClient')
    end

    it "should set the access tokens" do
      expect(@private_client.access_token).to_not be(nil)
      expect(@public_client.access_token).to_not be(nil)
    end
  end
end
