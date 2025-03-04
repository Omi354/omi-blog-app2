class Apps::FavoritesController < Apps::ApplicationController
  def index
    @favorite_articles = current_user.favorite_articles
  end
end
