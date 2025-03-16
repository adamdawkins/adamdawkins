module ArticlesHelper
  def article_permalink_path(article)
    return '#' unless article.published_at
    
    year = article.published_at.year
    ordinal_day = article.published_at.yday
    time = article.published_at.strftime('%H%M%S')
    
    articles_permalink_path(year: year, ordinal_day: ordinal_day, time: time)
  end
end