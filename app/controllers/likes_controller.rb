class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    article = Article.find(params[:article_id])
    article.likes.create(user_id: current_user.id)
    flash[:notice] = "いいねしました"
    redirect_to article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    article.likes.find_by(user_id: current_user.id).destroy!
    flash[:notice] = "いいねを削除しました"
    redirect_to article_path(article), status: :see_other
  end


end
