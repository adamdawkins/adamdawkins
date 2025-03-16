class ArticlesController < ApplicationController
  before_action :authenticate_adam!, only: %i[new edit create update destroy]
  before_action :set_article, only: %i[edit update destroy]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/1
  def show
    if params[:id]
      @article = Article.find(params[:id])
    else
      @article = Article.find_by_permalink(params.permit!.to_h)
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      if @article.published_at
        redirect_to articles_permalink_path(year: @article.published_at.year, 
                                  ordinal_day: @article.published_at.yday, 
                                  time: @article.published_at.strftime('%H%M%S')), 
                  notice: "Article was successfully created."
      else
        redirect_to article_path(@article), notice: "Article was successfully created."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      if @article.published_at
        redirect_to articles_permalink_path(year: @article.published_at.year, 
                                    ordinal_day: @article.published_at.yday, 
                                    time: @article.published_at.strftime('%H%M%S')), 
                    notice: "Article was successfully updated.", 
                    status: :see_other
      else
        redirect_to article_path(@article), notice: "Article was successfully updated.", status: :see_other
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
    redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :published_at)
    end
end