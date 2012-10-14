class FeedItem < ActiveRecord::Base
  belongs_to :feed

  def next
    FeedItem.where("feed_id = ? and id > ?", self.feed_id, self.id).order(:id).first
  end

  def previous
    FeedItem.where("feed_id = ? and id < ?", self.feed_id, self.id).order(:id).last
  end

  def extra_css
    self.feed.extra_css
  end

  def to_s
    "[#{feed}/#{title} ##{guid}]"
  end
end
