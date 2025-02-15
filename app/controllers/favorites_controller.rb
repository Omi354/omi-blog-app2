class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_articles = current_user.favorite_articles
  end

end
