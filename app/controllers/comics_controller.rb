class ComicsController < ApplicationController
  def index
    @feeds = feeds_for_user
  end

  def strip
    params.inspect
    @feed = strip_feed()
    @feed_item = strip_feed_item(@feed)
    render :layout => false
  end

private
  def feeds_for_user
    user_or_anon.feeds
  end

  def strip_feed()
    Feed.find(params[:feed_id])
  end

  def strip_feed_item(feed)
    strip_id = params[:strip_id]
    feed_item = feed.feed_items.where("id = ? ", strip_id).first

    params[:direction] == 'next' ? feed_item.next : feed_item.previous
  end
end
