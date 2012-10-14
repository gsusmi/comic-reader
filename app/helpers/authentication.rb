module Authentication
protected
  def authenticate
    lookup_user || auth_redirect
  end

  def auth_redirect
    session[:redirect] = request.fullpath unless request.xhr?
    logger.info("auth_redirect from #{session[:redirect]}")
    redirect_to(auth_link)
    false
  end

  def auth_link
    "/auth/#{default_provider}"
  end

  def find_user_or_anon
    lookup_user
    @authentication_link = auth_link
    @user_or_anon = self.user_or_anon
  end

  def default_provider
    'open_id'
  end

  # Current user or the anonymous user
  def user_or_anon
    self.current_user || self.anon_user
  end

  def current_user
    @user
  end

  def anon_user
    @anon_user ||= AnonymousUser.new
  end

  def current_user=(user)
    @user = user
    session[:uid] = @user.uid if @user
  end

  def lookup_user
    return self.current_user if self.current_user
    if session[:uid]
      self.current_user = User.find_by_uid(session[:uid])
    end
    self.current_user
  end
end
