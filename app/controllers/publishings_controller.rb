class PublishingsController < ApplicationController
  before_action :authenticate_adam!

  def create
    note = Note.find(params[:note_id])
    note.update!(published_at: Time.current)

    redirect_to note
  end

  def destroy
    note  = Note.find(params[:note_id])
    note.update!(published_at: nil)
    redirect_to note
  end
end
