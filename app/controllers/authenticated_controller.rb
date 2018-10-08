class AuthenticatedController < ApplicationController
  def home
    @feed = Feed.where(user_id: current_user.id).order("created_at desc")
  end

  def suggested_follows
    @users = User.all
  end
end
