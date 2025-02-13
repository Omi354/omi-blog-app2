class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "コメントに成功しました"
      redirect_to article_path(article)
    else
      flash.now[:alert] = "コメントに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
