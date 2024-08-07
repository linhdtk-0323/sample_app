class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params.dig(:password_reset, :email)&.downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "email_instruct"
      redirect_to root_url
    else
      flash.now[:danger] = t "email_not_found"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      log_in @user
      @user.update_column :reset_digest, nil
      flash[:success] = t "reseted_noti"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit User::PERMITTED_RESET
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless @user&.activated? && @user&.authenticated?(:reset,
                                                      params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "expired_noti"
    redirect_to new_password_reset_url
  end
end
