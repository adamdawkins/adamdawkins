require "rails_helper"

RSpec.describe PublishingsController, type: :routing do
  describe "routing" do
    it "routes POST /notes/1/publishings to #create" do
     expect(post: "/notes/1/publishings").to route_to("publishings#create", note_id: "1")
    end

     it "routes DELETE /notes/1/publishings to #destroy" do
     expect(delete: "/notes/1/publishings").to route_to("publishings#destroy", note_id: "1")
     end
  end
end
