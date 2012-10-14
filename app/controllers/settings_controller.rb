require 'set'

class SettingsController < ApplicationController
  include Authentication

  before_filter :authenticate

  def index
    @available_feeds = Feed.available_feeds
    @subscribed_feeds = Set.new(self.user_or_anon.feeds.map(&:id))
  end

  def update
    logger.info("params: #{params.inspect}")
    user = self.current_user
    user.feeds =
      params.keys.find_all { |key| key =~ /^feed_\d+/ }.map { |key|
        Feed.find(params[key].to_i)
      }
    user.save!
    flash[:message] = 'Saved your subscriptions'
    redirect_to(action: 'index')
  end
end
