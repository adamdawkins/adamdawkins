require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
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
    cell_selector = 'article>p'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
