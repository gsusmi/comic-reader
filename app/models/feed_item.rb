class FeedItem < ActiveRecord::Base
  belongs_to :feed

  def self.next(feed_id, item_id)
    FeedItem.where("feed_id = #{feed_id} and id > #{item_id}").order(:id).first
  end

  def self.previous(feed_id, item_id)
    FeedItem.where("feed_id = #{feed_id} and id < #{item_id}").order(:id).last
  end

  def to_s
    "[#{feed}/#{title} ##{guid}]"
  end
end
