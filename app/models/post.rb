class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 180 }
  after_commit :build_feed

  def build_feed_in_sync(post_id)
    post = Post.find(post_id)
    # add the post to the feed of this user
    Feed.create!(user_id: post.user_id, post_id: post_id)
    post_creator = User.find(post.user_id)
    ActionCable.server.broadcast("feed_#{post.user_id}", message: post.content)
    # find all of his followers and add this post to their feed
    followers = Follower.where(user_id: post.user_id)

    followers.each do |follower|
      Feed.create!(user_id: follower.follower_user_id, post_id: post_id)
      # now we can just push this feed item to the user's feed
      ActionCable.server.broadcast("feed_#{follower.follower_user_id}",
        message: post.content,
        email: post_creator.email
      )
    end
  end

  def build_feed
      # need to build feed here as heroku does not allow Sidekiq in free tier
      build_feed_in_sync(self.id)
      
      #BuildFeedWorker.perform_async(self.id)
  end
end
