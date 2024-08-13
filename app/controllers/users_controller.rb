class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.all, items: Settings.page_10)
  end

  def show
    @page, @microposts = pagy @user.microposts, items: Settings.page_10
    return if @user

    flash[:warning] = t "view.users.warning"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "view.activation.flash_active"
      redirect_to root_url, status: :see_other
    else
      flash.now[:error] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return if @user

    flash[:warning] = t "view.users.warning"
    redirect_to root_path
  end

  def update
    if @user.update user_params
      flash[:success] = t "view.users.updated"
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "view.users.delete_user_success"
    else
      flash[:danger] = t "view.users.delete_user_fail"
    end
    redirect_to users_path
  end

  def following
    @title = t "following"
    @pagy, @users = pagy @user.following, items: Settings.page_10
    render :show_follow
  end

  def followers
    @title = t "followers"
    @pagy, @users = pagy @user.followers, items: Settings.page_10
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit User::PERMITTED_ATRIBUTES
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "view.users.warning"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "view.users.login_confirm"
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t "view.users.edit_cant"
    redirect_to(root_url, status: :see_other)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
