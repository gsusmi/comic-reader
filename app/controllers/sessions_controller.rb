class SessionsController < ApplicationController
  protect_from_forgery except: :create

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    logger.info("Session redirect to: #{session[:redirect]}")
    redirect = session[:redirect]
    session.delete(:redirect)
    redirect_to(redirect || '/')
  end

protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
