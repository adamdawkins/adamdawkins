require 'rails_helper'

RSpec.describe "articles/edit", type: :view do
  let(:article) {
    Article.create!(
      title: "Test Article",
      body: "Article content"
    )
  }

  before do
    assign(:article, article)
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(article), "post" do
      assert_select "input[name=?]", "article[title]"
      assert_select "textarea[name=?]", "article[body]"
    end
  end
end