require 'rails_helper'

RSpec.describe NotesHelper, type: :helper do
  describe "#note_permalink_path" do
    let(:note) { Note.new(published_at: Time.zone.parse("2024-06-12T13:37:59")) }

    it "starts the URL with a slash" do
      expect(helper.note_permalink_path(note)).to start_with("/")
    end

    it "returns the published_at year as the first part of the URL" do
      expect(helper.note_permalink_path(note).split("/")[1]).to eq "2024"
    end

    it "returns the published_at ordinal day as the second part of the URL" do
      expect(helper.note_permalink_path(note).split("/")[2]).to eq "164"
    end
    it "returns 't' as the third part of the URL" do
      expect(helper.note_permalink_path(note).split("/")[3]).to eq "t"
    end
    it "returns the published_at time as the fourth part of the URL" do
      expect(helper.note_permalink_path(note).split("/")[4]).to eq "133759"
    end
  end
end
