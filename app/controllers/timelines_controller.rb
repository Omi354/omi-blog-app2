class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    following_ids = current_user.followings.ids
    @articles = []
    following_ids.each { |id|  @articles << User.find(id).articles }
    @articles = @articles.flatten
  end
end
