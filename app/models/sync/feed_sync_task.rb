module Sync
  class FeedSyncTask
    def perform(*args)
      FeedUpdateSet.new.each { |feed|
        FeedSync.sync(feed)
      }
    end
  end
end
