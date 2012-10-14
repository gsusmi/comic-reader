require 'cgi'

module Sync
  class FeedItemBuilder
    def self.build(entry, feed)
      item = FeedItem.new
      item.feed     = feed
      item.title    = encode(entry.title)
      item.url      = entry.feedburner_origLink || entry.link
      item.pub_date = entry.pubDate || entry.updated
      item.guid     = entry.guid || item.url
      Extract::FeedContentExtractor.new(feed.meta).extract(entry, item)
      item
    end

    def self.encode(text)
      TextEncoding.encode(text)
    end
  end
end
