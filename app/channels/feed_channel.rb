class FeedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "feed_#{params[:feed_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
