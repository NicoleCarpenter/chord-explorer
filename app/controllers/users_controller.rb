class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js

  # GET /users
  # GET /users.json
  def index
    @user = User.new
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if request.xhr?
      @saved_chords = @user.user_saved_chords.map(&:chord)
      @g = Chord.find_by(name: "G")
      @saved_songs = @user.user_songs.where(saved: true).map(&:song)

    end
  end

  # GET /users/new
  def new
    if request.xhr?
      @user = User.new
      puts "You made it via AJAX to users/new"
      respond_to do |format|
        format.html { render partial: 'new'}
      end
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if request.xhr?
      puts "you made it via AJAX"
      password = params[:user][:password]
      username =  params[:user][:username]
      @user = User.new(username: username, password: password)
      if @user.save
        session[:user_id] = @user.id
        @saved_chords = @user.user_saved_chords.map(&:chord)
        @g = Chord.find_by(name: "G")
      end
    end

    # respond_to do |format|
    #   if @user.save
    #     puts "SUCCESS"
    #     session[:user_id] = @user.id
    #     format.html { redirect_to welcome_index_path, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
