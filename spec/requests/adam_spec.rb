require 'rails_helper'

RSpec.describe "/adam", type: :request do
  describe "GET /adam/new" do
    it "renders a successful response" do
      get adam_new_url
      expect(response).to be_successful
    end
  end

  describe "POST /adam" do
    context "when the password matches the password credential" do
      it "redirects to the root page" do
        post adam_url, params: { password: "password" }
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(session[:adam]).to be_truthy
      end
    end
    context "when the password does not match the password cerdential" do
      it "renders a response with the 422 status code" do
        post adam_url, params: { password: "wrong" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
