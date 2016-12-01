class UsersController < ApplicationController
  def new
    return if check_already_singed_in
    @user = User.new
  end

  def create
    return if check_already_singed_in
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to tasks_url, notice: t('users.flash.create')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
