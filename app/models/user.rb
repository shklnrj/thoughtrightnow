class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_many :posts, dependent: :destroy
  has_many :followers
  has_one :feed

  def self.remove_duplicate_follower(user_id)
    # lets find all the followers of this user
    # for each follower, get the count. if the count is not 1
    # then make it 1
    followers = Follower.where(user_id: user_id)
    followers.each do |follower|
      this_follower_follow_count = Follower.where(user_id: user_id, follower_user_id: follower.follower_user_id).size
      if this_follower_follow_count >1
        number_of_times_to_delete_follow = this_follower_follow_count-1
        number_of_times_to_delete_follow.times do
          Follower.where(user_id: user_id, follower_user_id: follower.follower_user_id).delete
        end
      end
    end
  end
end
