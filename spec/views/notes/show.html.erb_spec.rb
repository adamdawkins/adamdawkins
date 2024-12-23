require 'rails_helper'

RSpec.describe "notes/show", type: :view do
  before(:each) do
    assign(:note, Note.create!(
      body: "MyText",
      published_at: Time.zone.now
    ))
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/MyText/)
  end
end
