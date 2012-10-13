require 'simple-rss'

module Sync
  class RssFeedBuilder
    def self.build(feed)
      SimpleRSS.parse(WebFetch.fetch(feed.rss))
    end
  end
end
