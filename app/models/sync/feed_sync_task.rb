module Sync
  class FeedSyncTask
    def self.run
      FeedUpdateSet.new.each { |feed|
        FeedSync.sync(feed)
      }
    end
  end
end
