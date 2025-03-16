require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    allow(view).to receive(:markdown).with(anything).and_return("Markdown content")
    allow(view).to receive(:note_permalink_path).with(anything).and_return("/test/path")
    
    assign(:notes, [
      Note.create!(
        body: "MyText",
        published_at: Time.zone.now
      ),
      Note.create!(
        body: "MyText",
        published_at: 1.day.ago
      )
    ])
  end

  it "renders a list of notes" do
    render
    expect(rendered).to include("Markdown content")
  end
end
