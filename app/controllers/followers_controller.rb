class FollowersController < ApplicationController
  def create
    @follower = Follower.new(post_params)

    respond_to do |format|
      if @follower.save
        format.html { redirect_to root_path, notice: 'You are following this user now.' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @follower.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:follower).permit(:user_id, :follower_user_id)
    end

end
