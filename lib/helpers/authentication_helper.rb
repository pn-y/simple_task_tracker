module AuthenticationHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def check_already_singed_in
    redirect_to tasks_url, notice: t('users.flash.already_signed_in') if current_user
  end

  def authenticate_user
    redirect_to new_session_url unless signed_in?
  end
end
