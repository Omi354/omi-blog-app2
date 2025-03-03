class Api::LikesController < Api::ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]
  before_action :set_article

  def show
    like_status = current_user.has_liked?(@article)
    render json: { hasLiked: like_status }
  end

  def create
    @article.likes.create(user_id: current_user.id)
    render json: { status: "ok", message: "いいねしました" }, status: :created
  end

  def destroy
    @article.likes.find_by(user_id: current_user.id).destroy!
    render json: { status: "ok", message: "いいねを削除しました" }, status: :ok
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
