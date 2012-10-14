class CreateFeedsUsers < ActiveRecord::Migration
  def change
    create_table :feeds_users do |t|
      t.references :feed
      t.references :user
    end
  end
end
