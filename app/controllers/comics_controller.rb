class ComicsController < ApplicationController
  def index
    @feeds = feeds_for_user
  end

  def strip
    params.inspect
    @feed = strip_feed()
    @feed_item = strip_feed_item()
    render :layout => false
  end

private
  def feeds_for_user
    user_or_anon.feeds
  end

  def strip_feed()
    Feed.find(params[:feed_id])
  end

  def strip_feed_item()
    feed_id = params[:feed_id]
    strip_id = params[:strip_id]
    params[:direction] == 'next' ? FeedItem.next(feed_id, strip_id) : FeedItem.previous(feed_id, strip_id)
  end
end
