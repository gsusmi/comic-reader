class NewUserSetup
  def self.setup(user)
    self.new(user).setup
  end

  def initialize(user)
    @user = user
  end

  def setup
    @user.feeds = DefaultFeedSelection.feeds
    @user.save!
  end
end
