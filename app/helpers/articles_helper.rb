module ArticlesHelper
  def article_permalink_path(article)
    year = article.published_at.year
    ordinal_day = article.published_at.yday
    "/#{year}/#{ordinal_day}/t/#{article.published_at.strftime('%H%M%S')}"
  end
end