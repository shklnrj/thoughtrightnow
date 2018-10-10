class DefaultController < ApplicationController
  skip_before_action :authenticate_user!
  def home
  end

  def profile
    if params[:username]
      profile = User.where(username: params[:username]).first
      if profile
        @profile = profile
        @feed = Feed.where(user_id: @profile.id).order("created_at desc")
      end
    end
  end
end
