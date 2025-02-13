class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def edit

  end

  def update
  end

  private
  def profile_params
    params.require(:profile).permit(:birthday, :gender, :introduction, :nickname, :subscribed)
  end

  def set_profile
    @profile = current_user.profile
  end
end
