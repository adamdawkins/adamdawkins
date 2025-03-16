class HomeController < ApplicationController
  def index
    @recent_notes = Note.order(published_at: :desc).limit(5)
  end
end
