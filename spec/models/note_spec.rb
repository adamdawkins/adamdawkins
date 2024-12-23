require 'rails_helper'

RSpec.describe Note, type: :model do
  it "is valid with a body" do
    expect(Note.new(body: "Hello")).to be_valid
  end

  it "is not valid without a body" do
    expect(Note.new(body: nil)).to_not be_valid
  end

  describe ".find_by_permalink" do
    let!(:note) { Note.create!(body: "Hello", published_at: Time.zone.parse("2024-06-12T13:00:59")) }
    before { Note.create!(body: "World", published_at: Time.zone.parse("2024-06-13T12:00:59")) }

    it "returns the note with the publilshed_at matching the permalink" do
      expect(Note.find_by_permalink({ year: "2024", ordinal_day: "164", time: "130059" })).to eq(note)
    end
  end
end
