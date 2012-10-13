module Sync
  class RssFeedMetadataSync
    def self.sync_feed_metadata(feed, rss)
      self.new(feed, rss).sync
    end

    def initialize(feed, rss)
      @feed = feed
      @rss = rss
    end

    def sync
      # Also updates the timestamp
      @feed.update_attributes!(
        display_title: @rss.feed.title,
        source_link: @rss.feed.link)
    end
  end
end
