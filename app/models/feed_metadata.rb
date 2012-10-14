require 'yaml'
require 'ostruct'

class FeedMetadata
  FEED_CFG = YAML.load_file(File.join(Rails.root, 'config/feeds.yml'))
  FEED_MAP = Hash[ FEED_CFG.map { |f| [f['name'], f] } ]

  attr_reader :meta

  def self.feeds
    FEED_CFG
  end

  def self.feed_by_name(name)
    self.new(FEED_MAP[name])
  end

  def initialize(feed)
    @feed = OpenStruct.new(feed)
    @meta = OpenStruct.new(@feed.meta || { })
  end

  def valid_entry?(entry)
    self.entry_filter.valid?(entry)
  end

  def entry_filter
    @entry_filter ||= FeedEntryFilter.filter(@meta.filter)
  end

  def extractor
    @extractor ||= extractor_factory.new(self)
  end

private
  def extractor_factory
    return Extract::WebExtractor if @meta.image_xpath
    @feed.extractor ? @feed.extractor.constantize : Extract::FeedContentExtractor
  end
end
