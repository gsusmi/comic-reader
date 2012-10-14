module Extract
  class FeedContentExtractor
    def initialize(feed_metadata)
      @feed_metadata = feed_metadata
    end

    def extract(entry, feed_item)
      feed_item.content = extract_content(entry)
    end

  private
    def extract_content(entry)
      CGI.unescape_html(TextEncoding.encode(entry.description || entry.summary))
    end
  end
end
