class HomeController < ApplicationController
  def index
    @title = 'デイトラ'
  end

  def show
    render 'home/show'
  end
end

