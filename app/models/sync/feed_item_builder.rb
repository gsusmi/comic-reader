require 'cgi'

module Sync
  class FeedItemBuilder
    def self.build(entry, feed)
      item = FeedItem.new
      item.feed     = feed
      item.title    = encode(entry.title)
      item.url      = entry.feedburner_origLink || entry.link
      item.content  = FeedContentExtractor.content(entry, feed)
      item.pub_date = entry.pubDate || entry.updated
      item.guid     = entry.guid || item.url
      item
    end

    def self.encode(text)
      TextEncoding.encode(text)
    end
  end
end
