class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "保存に成功しました"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "更新に成功しました"
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy!
    flash[:notice] = "削除しました"
    redirect_to root_path, status: :see_other
  end


  private
  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
