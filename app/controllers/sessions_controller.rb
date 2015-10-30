class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:users][:username].downcase)
    if @user && @user.authenticate(params[:users][:password])
      session[:user_id] = @user.id
      redirect_to welcome_index_path
    else
      @message = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_index_path
  end

end
