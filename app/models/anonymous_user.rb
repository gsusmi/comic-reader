class AnonymousUser
  def name
    'Log in'
  end

  def feeds
    DefaultFeedSelection.feeds
  end

  def anon?
    true
  end
end
