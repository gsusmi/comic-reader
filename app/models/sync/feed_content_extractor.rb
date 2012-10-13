module Sync
  class FeedContentExtractor
    def self.content(entry, feed)
      extractor = feed.meta.extractor
      extractor.extract(entry)
    end

    def initialize(feed_metadata)
      @feed_metadata = feed_metadata
    end

    def extract(entry)
      CGI.unescape_html(TextEncoding.encode(entry.description || entry.summary))
    end
  end
end
