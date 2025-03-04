class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show ]

  def index
    @articles = Article.includes(:user)
  end

  def show
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :eye_catch)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
