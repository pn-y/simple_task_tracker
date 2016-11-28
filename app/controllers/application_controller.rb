class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthenticationHelper
  helper_method :signed_in?, :current_user
end
