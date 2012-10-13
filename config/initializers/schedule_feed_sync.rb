if File.basename($0) != 'rake'
  Rails.logger.info("[Time.now] Starting delayed task")
  Sync::FeedSyncTask.new.perform
end
