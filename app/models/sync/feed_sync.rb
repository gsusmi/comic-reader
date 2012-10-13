module Sync
  class FeedSync
    include Logging

    def self.sync(feed)
      self.new(feed).sync
    end

    def initialize(feed)
      @feed = feed
    end

    def sync
      logger.info("Syncing feed: #{@feed}")
      rss_feed = RssFeedBuilder.build(@feed)
      FeedItemSync.sync(@feed, rss_feed)
      RssFeedMetadataSync.sync_feed_metadata(@feed, rss_feed)
    rescue SyncError => e
      logger.error("Error syncing feed: #{@feed.name}: #{e}")
      logger.error(e.backtrace.join("\n"))
    end
  end
end
