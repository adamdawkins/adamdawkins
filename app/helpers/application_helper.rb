module ApplicationHelper
   def markdown(text)
    options = []
    Markdown.new(text, *options).to_html.html_safe
  end
end
