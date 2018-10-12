class Follower < ApplicationRecord
  validates_uniqueness_of :follower_user_id, scope: :user_id, message: "You are already following the user!"
end
