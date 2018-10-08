class BuildFeedWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    # add the post to the feed of this user
    Feed.create!(user_id: post.user_id, post_id: post_id)
    # find all of his followers and add this post to their feed
    followers = Follower.where(user_id: post.user_id)

    followers.each do |follower|
      Feed.create!(user_id: follower.follower_user_id, post_id: post_id)
    end
  end
end
