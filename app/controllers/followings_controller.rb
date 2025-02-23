class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    debugger
    user = User.find(params[:user_id])
    current_user.follow!(user)
    flash[:notice] = "フォローしました"
    redirect_to account_path(user)
  end

end