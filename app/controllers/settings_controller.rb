require 'set'

class SettingsController < ApplicationController
  include Authentication

  before_filter :authenticate

  def index
    @available_feeds = Feed.available_feeds
    @subscribed_feeds = Set.new(self.user_or_anon.feeds.map(&:id))
  end
end
