require 'rails_helper'

RSpec.describe Article, type: :model do
  it "is valid with a title and body" do
    expect(Article.new(title: "Test Article", body: "Hello")).to be_valid
  end

  it "is not valid without a title" do
    expect(Article.new(title: nil, body: "Hello")).to_not be_valid
  end

  it "is not valid without a body" do
    expect(Article.new(title: "Test Article", body: nil)).to_not be_valid
  end

  describe ".find_by_permalink" do
    let!(:article) { Article.create!(title: "Test Article", body: "Hello", published_at: Time.zone.parse("2024-06-12T13:00:59")) }
    before { Article.create!(title: "Another Article", body: "World", published_at: Time.zone.parse("2024-06-13T12:00:59")) }

    it "returns the article with the published_at matching the permalink" do
      expect(Article.find_by_permalink({ year: "2024", ordinal_day: "164", time: "130059" })).to eq(article)
    end
  end
end