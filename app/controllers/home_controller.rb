class HomeController < ApplicationController
  def index
    @recent_notes = Note.order(published_at: :desc).limit(5)
    @recent_articles = Article.order(published_at: :desc).limit(3)
  end
end
