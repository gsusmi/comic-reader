class ApplicationController < ActionController::Base
  protect_from_forgery
  include Authentication

  before_filter :find_user_or_anon
end
