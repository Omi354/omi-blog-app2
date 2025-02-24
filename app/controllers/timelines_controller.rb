class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    @articles = Article.where(user_id: current_user.following_ids)
                      .includes(:user)
                      .order(created_at: :desc)
  end
end
