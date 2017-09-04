require "spec_helper"

RSpec.describe Gatekeeper::Client::OAuthClient do
  context "with a public and a private OAuth client already existing" do
    before do
      @private_client = Gatekeeper::Client::OAuthClient.find(client_id: 'ClientCredentialsClient',
                                                        client_secret: 'credentials')
    end

    it "should set the access token on a private client when credentials are passed" do
      expect(@private_client.access_token).to_not be(nil)
    end
  end
end
