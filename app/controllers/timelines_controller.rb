class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    @articles = Article.where(user_id: current_user.followings.pluck(:id))
                      .includes(:user)
                      .order(created_at: :desc)
  end
end
