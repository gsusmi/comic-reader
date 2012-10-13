module Sync
  class FeedSyncTask
    include ::Jobs::ScheduledJob
    include ::Logging
    run_every 10.seconds

    def perform(*args)
      logger.info("Updating feeds")
      FeedUpdateSet.new.each { |feed|
        FeedSync.sync(feed)
      }
    end
  end
end
