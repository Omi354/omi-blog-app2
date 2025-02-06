class HomeController < ApplicationController
  def index
    @article = Article.first
  end

  def show
    render 'home/show'
  end
end

