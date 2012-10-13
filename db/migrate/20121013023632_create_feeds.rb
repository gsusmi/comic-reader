class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :rss
      t.string :extractor

      t.string :display_title
      t.string :source_link
      t.datetime :last_sync_time
    end
  end
end
