class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 180 }
  after_commit :build_feed

  def build_feed
    BuildFeedWorker.perform_async(self.id)
  end
end
