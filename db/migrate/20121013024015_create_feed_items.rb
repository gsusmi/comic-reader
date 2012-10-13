class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :feed
      t.string     :guid
      t.string     :title
      t.string     :url
      t.string     :content
      t.string     :image_url
      t.integer    :content_width
      t.integer    :content_height
      t.datetime   :pub_date
      t.timestamps
    end
  end
end
