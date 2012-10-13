class Feed < ActiveRecord::Base
  attr_accessible :name, :rss, :extractor, :display_title, :source_link
  has_many :feed_items

  def to_s
    "Feed[#{name}]"
  end
end
