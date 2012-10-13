module Sync
  class FeedUpdateSet
    include Enumerable

    def each(&block)
      Feed.where("last_sync_time IS NULL OR last_sync_time < ?",
                 self.sync_epoch).each(&block)
    end

    def sync_epoch
      @epoch ||= 2.hours.ago
    end
  end
end
