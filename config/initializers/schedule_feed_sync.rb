if File.basename($0) != 'rake'
  STDERR.puts "Starting delayed task"
  Sync::FeedSyncTask.new.perform
end
