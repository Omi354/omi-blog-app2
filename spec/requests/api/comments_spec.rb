require 'rails_helper'

RSpec.describe "Api::Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article) }

  describe "GET /api/comments" do
    context "ログインしている場合" do
      before do
        post user_session_path, params: { user: { email: user.email, password: "password" } }
      end

      it "200 status" do
        get api_comments_path(article_id: article.id)
        res_body = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(res_body.size).to eq(comments.size)
        res_body.each_with_index do |comment, i|
          expect(comment.slice('id', 'content')).to eq({ 'id' => comments[i].id, 'content' => comments[i].content })
        end
      end
    end
  end
end
