class SessionsController < ApplicationController

  def new
    if request.xhr?
      respond_to do |format|
        format.html { render partial: 'new'}
      end
    end
  end

  def create
    @user = User.find_by(username: params[:users][:username].downcase)
    if @user && @user.authenticate(params[:users][:password])
      session[:user_id] = @user.id
      @saved_chords = @user.user_saved_chords.map(&:chord)
      @g = Chord.find_by(name: "G")
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
