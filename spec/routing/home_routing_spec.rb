require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes '/' to #index" do
      expect(get: "/").to route_to("home#index")
    end
  end
end
