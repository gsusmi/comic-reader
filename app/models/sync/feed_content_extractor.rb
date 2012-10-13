module Sync
  class FeedContentExtractor
    def self.content(entry)
      CGI.unescape_html(TextEncoding.encode(entry.description || entry.summary))
    end
  end
end
