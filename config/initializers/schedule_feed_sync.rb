if File.basename($0) != 'rake' && Rails.env.production?
  Rails.logger.info("[#{Time.now}] Starting delayed task")
  Sync::FeedSyncTask.new.perform
end
