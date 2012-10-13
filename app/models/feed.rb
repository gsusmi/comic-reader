class Feed < ActiveRecord::Base
  attr_accessible :name, :rss, :extractor, :display_title, :source_link
  has_many :feed_items, order: 'pub_date DESC'

  def current
    self.feed_items.first
  end

  def empty?
    self.feed_items.empty?
  end

  def valid_entry?(entry)
    self.meta.valid_entry?(entry)
  end

  def meta
    @meta ||= FeedMetadata.feed_by_name(self.name)
  end

  def to_s
    "Feed[#{name}]"
  end
end
