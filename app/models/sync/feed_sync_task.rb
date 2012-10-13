module Sync
  class FeedSyncTask
    include ::Jobs::ScheduledJob

    run_every 5.minutes

    def perform(*args)
      FeedUpdateSet.new.each { |feed|
        FeedSync.sync(feed)
      }
    end
  end
end
