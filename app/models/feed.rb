class Feed < ActiveRecord::Base
  attr_accessible :name, :rss, :extractor, :display_title, :source_link
  has_many :feed_items

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
