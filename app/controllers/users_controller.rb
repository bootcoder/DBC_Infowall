class UsersController < ApplicationController

  include SessionsHelper

  before_action :authenticate_user!, :except => [:cards]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:session] = "Logged In"
      session[:id] = @user.id
      redirect_to root_path
    else
      flash[:new_user_error] = @user.errors
      render :new
    end
  end

  private


  # Looks like this is repeated in the EventsController. You should be able to
  # move it to the ApplicationController and still reference it here on line 5.
  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def user_params
    params.require(:user).permit(:username,:password, :password_confirmation)
  end

end
