module Sync
  class FeedItemSync
    include Logging

    def self.sync(feed, rss)
      self.new(feed, rss).sync
    end

    def initialize(feed, rss)
      @feed = feed
      @rss = rss
    end

    def sync
      @rss.entries.each { |entry|
        if @feed.valid_entry?(entry)
          create_item(entry)
        else
          log_invalid_item(entry)
        end
      }
    end

  private
    def create_item(entry)
      new_feed_item = FeedItemBuilder.build(entry, @feed)
      FeedItem.transaction {
        existing_feed_item =
          FeedItem.find_by_guid(new_feed_item.guid)
        create_new_item(new_feed_item) unless existing_feed_item
      }
    end

    def create_new_item(new_feed_item)
      logger.info("Creating new feed item: #{new_feed_item.title} for feed #{@feed}")
      new_feed_item.save!
    end

    def log_invalid_item(entry)
      logger.info("Ignoring entry: #{entry.title}, invalid for feed #{@feed}")
    end
  end
end