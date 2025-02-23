class AccountsController < ApplicationController
  def show
    if User.find(params[:id]) == current_user
      redirect_to profile_path
    else
      @user = User.find(params[:id])
    end
  end
end
