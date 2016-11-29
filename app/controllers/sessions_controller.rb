class SessionsController < ApplicationController
  def new
    check_already_singed_in
  end

  def create
    return if check_already_singed_in
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      flash[:notice] = t('sessions.flash.create')
      sign_in user
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def destroy
    if signed_in?
      sign_out
      flash[:notice] = t('sessions.flash.destroy')
    end
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
