class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :feed
      t.integer    :item_number
      t.string     :source_url
      t.string     :image_url
      t.integer    :image_width
      t.integer    :image_height
      t.datetime   :date
      t.timestamps
    end
  end
end
