class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = '保存に成功しました'
      redirect_to article_path(@article)
    else
      flash.now[:alert] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = '更新に成功しました'
      redirect_to article_path(@article)
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end

  end


  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end

