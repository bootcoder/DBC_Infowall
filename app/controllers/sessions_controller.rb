class SessionsController < ApplicationController

  def auth
    @auth = request.env['omniauth.auth']['credentials']
    Token.create(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime)
    render :auth
  end

  def auth_fail
    p "! @ % " * 30
    # You should still have access to the params object in views, I think
    @params = params
    render :fail
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_username(session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      session[:id] = @user.id
      flash[:session] = "Logged In"
      redirect_to events_path
    else
      flash[:invalid_login] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    flash[:session] = "Logged Out"
    session[:id] = nil
    @current_user = nil
    redirect_to root_path
  end


  private

  def session_params
    params.require(:session).permit(:username, :password, :password_confirmation)
  end

end
