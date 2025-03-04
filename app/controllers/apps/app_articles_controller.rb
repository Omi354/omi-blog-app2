class Apps::AppArticlesController < Apps::ApplicationController
  before_action :set_article_with_user, only: [ :edit, :update ]

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
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
    article = current_user.articles.find(params[:id])
    article.destroy!
    flash[:notice] = "削除しました"
    redirect_to root_path, status: :see_other
  end


  private
  def article_params
    params.require(:article).permit(:title, :content, :eye_catch)
  end

  def set_article_with_user
    @article = current_user.articles.find(params[:id])
  end
end
