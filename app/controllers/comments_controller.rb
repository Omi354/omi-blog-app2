class CommentsController < ApplicationController
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
  end
end
