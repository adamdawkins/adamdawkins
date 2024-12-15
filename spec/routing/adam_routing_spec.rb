require "rails_helper"

RSpec.describe AdamController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/adam/new").to route_to("adam#new")
    end

    it "routes to #create" do
      expect(post: "/adam").to route_to("adam#create")
    end
  end
end
