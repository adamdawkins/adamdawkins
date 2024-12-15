require 'rails_helper'

RSpec.describe "Publishings", type: :request do
  describe "POST /notes/1/publishings" do
    let(:note) { Note.create!(body: "Hello, world!") }

    context "with adam" do
      before { post adam_path, params: { password: 'password' } }

      it "sets the published_at on the note" do
        post note_publishings_path(note)
        note.reload
        expect(note.published_at).to be_present
      end
    end

    context "without me" do
      it "redirects to root" do
        post note_publishings_path(note)
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe "DELETE /notes/1/publishings" do
    let(:note) { Note.create!(body: "Hello, world!", published_at: Time.current) }

    context "with adam" do
      before { post adam_path, params: { password: 'password' } }

      it "removes the published_at on the note" do
        delete note_publishings_path(note)
        note.reload
        expect(note.published_at).to be_nil
      end
    end

    context "without me" do
      it "redirects to root" do
        delete note_publishings_path(note)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
