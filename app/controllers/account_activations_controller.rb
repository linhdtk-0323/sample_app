class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      edit_active user
    else
      flash[:danger] = t "view.activation.invalid"
      redirect_to root_url
    end
  end

  def edit_active user
    user.activate
    user.update_attribute :activated, true
    user.update_attribute :activated_at, Time.zone.now
    log_in user
    flash[:success] = t "view.activation.success"
    redirect_to user
  end
end
