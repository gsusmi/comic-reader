module Sync
  class FeedItemBuilder
    def self.build(entry, feed)
      item = FeedItem.new
      item.feed     = feed
      item.title    = encode(entry.title)
      item.url      = entry.feedburner_origLink || entry.link
      item.content  = encode(entry.description)
      item.pub_date = entry.pubDate
      item.guid     = entry.guid || item.url
      item
    end

    def self.encode(text)
      TextEncoding.encode(text)
    end
  end
end
