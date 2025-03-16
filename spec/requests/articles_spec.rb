require 'rails_helper'

RSpec.describe "/articles", type: :request do
  let(:valid_attributes) { { title: "Test Article", body: "Hello" } }
  let(:published_attributes) { { title: "Test Article", body: "Hello", published_at: Time.zone.now } }

  let(:invalid_attributes) { { title: nil, body: nil } }

  describe "GET /articles" do
    it "renders a successful response" do
      Article.create! published_attributes
      get articles_url
      expect(response).to be_successful
    end
  end

  describe "GET /articles/1" do
    context "with a published article" do
      let(:article) { Article.create! published_attributes }
      it "renders a successful response" do
        get article_url(article)
        expect(response).to be_successful
      end
    end
  end

  describe "GET /articles/2024/32/t/125959" do
    before { Article.create! valid_attributes.merge(published_at: Time.zone.parse("2024-02-01T12:59:59")) }
    it "renders a successful response" do
      get "/articles/2024/32/t/125959"
      expect(response).to be_successful
    end
  end

  describe "GET /articles/new" do
    subject(:req) { get new_article_url }

    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "renders a successful response" do
        req
        expect(response).to be_successful
      end
    end

    context "without me" do
      it "redirects to root" do
        req
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET /articles/1/edit" do
    subject(:req) { get edit_article_url(Article.create! valid_attributes) }

    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "renders a successful response" do
        req
        expect(response).to be_successful
      end
    end
    context "without me" do
      it "redirects to root" do
        req
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /articles" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      context "with valid parameters" do
        it "creates a new Article" do
          expect {
            post articles_url, params: { article: valid_attributes }
          }.to change(Article, :count).by(1)
        end

        it "redirects to the created article" do
          post articles_url, params: { article: valid_attributes }
          expect(response).to redirect_to(article_url(Article.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Article" do
          expect {
            post articles_url, params: { article: invalid_attributes }
          }.to change(Article, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post articles_url, params: { article: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context "without adam" do
      it "redirects to root" do
        post articles_url, params: { article: valid_attributes }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH /articles/1" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      context "with valid parameters" do
        let(:new_attributes) { { title: "Updated Title", body: "Hello, World!" } }

        it "updates the requested article" do
          article = Article.create! valid_attributes
          patch article_url(article), params: { article: new_attributes }
          article.reload
          expect(article.title).to eq("Updated Title")
          expect(article.body).to eq("Hello, World!")
        end

        it "redirects to the article" do
          article = Article.create! valid_attributes
          patch article_url(article), params: { article: new_attributes }
          article.reload
          expect(response).to redirect_to(article_url(article))
        end
      end

      context "with invalid parameters" do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          article = Article.create! valid_attributes
          patch article_url(article), params: { article: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context "without adam" do
      it "redirects to root" do
        article = Article.create! valid_attributes
        patch article_url(article), params: { article: { title: "Updated Title", body: "Hello, World!" } }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with adam" do
      before { post adam_path, params: { password: "password" } }

      it "destroys the requested article" do
        article = Article.create! valid_attributes
        expect {
          delete article_url(article)
        }.to change(Article, :count).by(-1)
      end

      it "redirects to the articles list" do
        article = Article.create! valid_attributes
        delete article_url(article)
        expect(response).to redirect_to(articles_url)
      end
    end
    context "without adam" do
      it "redirects to root" do
        article = Article.create! valid_attributes
        delete article_url(article)

        expect(response).to redirect_to(root_path)
      end
    end
  end
end