require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before do
    allow(view).to receive(:markdown).with(anything).and_return("Markdown content")
    allow(view).to receive(:article_permalink_path).with(anything).and_return("/test/path")
    
    assign(:articles, [
      Article.create!(
        title: "Test Article 1",
        body: "First article content",
        published_at: Time.zone.now
      ),
      Article.create!(
        title: "Test Article 2",
        body: "Second article content",
        published_at: Time.zone.now
      )
    ])
  end

  it "renders a list of articles" do
    render
    expect(rendered).to include("Test Article 1")
    expect(rendered).to include("Test Article 2")
  end
end