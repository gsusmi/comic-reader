class FeedItem < ActiveRecord::Base
  belongs_to :feed

  def to_s
    "[#{feed}/#{title} ##{guid}]"
  end
end
