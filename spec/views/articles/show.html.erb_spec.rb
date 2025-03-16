require 'rails_helper'

RSpec.describe "articles/show", type: :view do
  before do
    allow(view).to receive(:markdown).with(anything).and_return("Markdown content")
    allow(view).to receive(:article_permalink_path).with(anything).and_return("/test/path")
    
    assign(:article, Article.create!(
      title: "Test Article",
      body: "Article content",
      published_at: Time.zone.now
    ))
  end

  it "renders article attributes" do
    render
    expect(rendered).to include("Test Article")
  end
end