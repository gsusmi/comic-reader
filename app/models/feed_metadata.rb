require 'yaml'

class FeedMetadata
  FEED_CFG = YAML.load_file(File.join(Rails.root, 'config/feeds.yml'))
  FEED_MAP = Hash[ FEED_CFG.map { |f| [f['name'], f] } ]

  def self.feeds
    FEED_CFG
  end

  def self.feed_by_name(name)
    self.new(FEED_MAP[name])
  end

  def initialize(feed)
    @feed = feed
  end

  def valid_entry?(entry)
    self.entry_filter.valid?(entry)
  end

  def entry_filter
    @entry_filter ||= FeedEntryFilter.filter(@feed['filter'])
  end

  def extractor
    @extractor ||= Sync::FeedContentExtractor.new(self)
  end
end
