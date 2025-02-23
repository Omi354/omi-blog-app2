class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    flash[:notice] = "フォローしました"
    redirect_to account_path(user)
  end

  def destroy
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    flash[:notice] = "フォローを解除しました"
    redirect_to account_path(user)
  end
end
