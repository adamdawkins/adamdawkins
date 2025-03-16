module ArticlesHelper
  def article_permalink_path(article)
    return '#' unless article.published_at
    
    year = article.published_at.year
    ordinal_day = article.published_at.yday
    time = article.published_at.strftime('%H%M%S')
    slug = article.title.parameterize
    
    articles_permalink_path(year: year, ordinal_day: ordinal_day, time: time, slug: slug)
  end
  
  def article_permalink_url(article)
    return '#' unless article.published_at
    
    year = article.published_at.year
    ordinal_day = article.published_at.yday
    time = article.published_at.strftime('%H%M%S')
    slug = article.title.parameterize
    
    articles_permalink_url(year: year, ordinal_day: ordinal_day, time: time, slug: slug)
  end
end