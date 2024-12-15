require 'rails_helper'

RSpec.describe "/notes", type: :request do
  let(:valid_attributes) { { body: "Hello" } }

  let(:invalid_attributes) { { body: nil } }

  describe "GET /notes" do
    it "renders a successful response" do
      Note.create! valid_attributes
      get notes_url
      expect(response).to be_successful
    end
  end

  describe "GET /notes/1" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get note_url(note)
      expect(response).to be_successful
    end
  end

  describe "GET /notes/new" do
    subject(:req) { get new_note_url }

    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "renders a successful response" do
        req
        expect(response).to be_successful
      end
    end

    context "without me" do
      it "redirects to root" do
        req
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET /notes/1/edit" do
    subject(:req) { get edit_note_url(Note.create! valid_attributes) }

    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "renders a successful response" do
        req
        expect(response).to be_successful
      end
    end
    context "without me" do
      it "redirects to root" do
        req
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /notes" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      context "with valid parameters" do
        it "creates a new Note" do
          expect {
            post notes_url, params: { note: valid_attributes }
          }.to change(Note, :count).by(1)
        end

        it "redirects to the created note" do
          post notes_url, params: { note: valid_attributes }
          expect(response).to redirect_to(note_url(Note.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Note" do
          expect {
            post notes_url, params: { note: invalid_attributes }
          }.to change(Note, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post notes_url, params: { note: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context "without adam" do
      it "redirects to root" do
        post notes_url, params: { note: valid_attributes }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH /notes/1" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      context "with valid parameters" do
        let(:new_attributes) { { body: "Hello, World!" } }

        it "updates the requested note" do
          note = Note.create! valid_attributes
          patch note_url(note), params: { note: new_attributes }
          note.reload
          expect(note.body).to eq("Hello, World!")
        end

        it "redirects to the note" do
          note = Note.create! valid_attributes
          patch note_url(note), params: { note: new_attributes }
          note.reload
          expect(response).to redirect_to(note_url(note))
        end
      end

      context "with invalid parameters" do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          note = Note.create! valid_attributes
          patch note_url(note), params: { note: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context "without adam" do
      it "redirects to root" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: { body: "Hello, World!" } }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "destroys the requested note" do
        note = Note.create! valid_attributes
        expect {
          delete note_url(note)
        }.to change(Note, :count).by(-1)
      end

      it "redirects to the notes list" do
        note = Note.create! valid_attributes
        delete note_url(note)
        expect(response).to redirect_to(notes_url)
      end
    end
    context "without adam" do
      it "redirects to root" do
        note = Note.create! valid_attributes
        delete note_url(note)

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
