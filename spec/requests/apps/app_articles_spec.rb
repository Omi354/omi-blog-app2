require 'rails_helper'

RSpec.describe "AppArticles", type: :request do
  let!(:user) { create(:user) }

  describe "POST /app_articles" do
    context 'ログインしている場合' do
      before do
        post user_session_path, params: { user: { email: user.email, password: "password" } }
      end

      it "記事が保存される" do
        article_params = attributes_for(:article)
        expect {
          post app_articles_path, params: { article: article_params }
        }.to change(Article, :count).by(1)
        expect(response).to have_http_status(302)
      end
    end

    context 'ログインしていない場合' do
      it "記事が保存されず、ログイン画面に遷移する" do
        article_params = attributes_for(:article)
        expect {
          post app_articles_path, params: { article: article_params }
        }.to change(Article, :count).by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
