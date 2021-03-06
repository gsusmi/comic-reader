class Feed < ActiveRecord::Base
  attr_accessible :name, :rss, :extractor, :display_title, :source_link
  has_many :feed_items, order: 'pub_date DESC, id DESC'

  has_and_belongs_to_many :users

  def self.available_feeds
    self.all(order: 'name ASC')
  end

  def hashtag
    self.name.downcase.gsub(/[^a-zA-Z0-9-]+/, ' ').gsub(' ', '-')
  end

  def current
    self.feed_items.first
  end

  def extra_css
    self.meta.extra_css
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

  def extractor
    self.meta.extractor
  end

  def to_s
    "Feed[#{name}]"
  end
end
