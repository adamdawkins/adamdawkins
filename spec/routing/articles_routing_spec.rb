require "rails_helper"

RSpec.describe ArticlesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/articles").to route_to("articles#index")
    end

    it "routes to #new" do
      expect(get: "/articles/new").to route_to("articles#new")
    end

    it "routes to #show" do
      expect(get: "/articles/1").to route_to("articles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/articles/1/edit").to route_to("articles#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/articles").to route_to("articles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/articles/1").to route_to("articles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/articles/1").to route_to("articles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/articles/1").to route_to("articles#destroy", id: "1")
    end

    it "routes permalinks to #show" do
      expect(get: "/articles/2024/32/t/125959").to route_to(
        controller: "articles",
        action: "show",
        year: "2024",
        ordinal_day: "32",
        time: "125959"
      )
    end
  end
end