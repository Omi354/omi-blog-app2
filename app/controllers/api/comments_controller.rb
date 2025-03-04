class Api::CommentsController < Api::ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
