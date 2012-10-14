class DefaultFeedSelection
  def self.feeds
    Feed.available_feeds
  end
end
