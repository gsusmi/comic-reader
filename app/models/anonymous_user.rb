class AnonymousUser
  def name
    'not logged in'
  end

  def feeds
    DefaultFeedSelection.feeds
  end

  def anon?
    true
  end
end
