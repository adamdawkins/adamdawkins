require 'rails_helper'

RSpec.describe "/adam", type: :request do
  describe "GET /adam/new" do
    it "renders a successful response" do
      get adam_new_url
      expect(response).to be_successful
    end
  end
end
