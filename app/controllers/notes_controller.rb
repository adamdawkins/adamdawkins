class NotesController < ApplicationController
  before_action :authenticate_adam!, only: %i[ new edit create update destroy]
  before_action :set_note, only: %i[ edit update destroy ]

  # GET /notes
  def index
    @notes = Note.all
  end

  # GET /notes/1
  def show
    if params[:id]
    @note = Note.find(params[:id])
    else
      @note = Note.find_by_permalink(params.permit!.to_h)
    end
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      if @note.published_at
        redirect_to notes_permalink_path(year: @note.published_at.year, 
                                  ordinal_day: @note.published_at.yday, 
                                  time: @note.published_at.strftime('%H%M%S')), 
                  notice: "Note was successfully created."
      else
        redirect_to note_path(@note), notice: "Note was successfully created."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      if @note.published_at
        redirect_to notes_permalink_path(year: @note.published_at.year, 
                                  ordinal_day: @note.published_at.yday, 
                                  time: @note.published_at.strftime('%H%M%S')), 
                  notice: "Note was successfully updated.", 
                  status: :see_other
      else
        redirect_to note_path(@note), notice: "Note was successfully updated.", status: :see_other
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
    redirect_to notes_path, notice: "Note was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:body, :published_at)
    end
end
