class UserSavedChordsController < ApplicationController
  before_action :set_user_saved_chord, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  # GET /user_saved_chords
  # GET /user_saved_chords.json
  def index
    if request.xhr?
      puts "You made it via AJAX"
      p @user_saved_escaped_chords = UserSavedChord.where(user_id: session[:user_id]).map(&:chord).map(&:escaped_name)

    end
  end

  # GET /user_saved_chords/1
  # GET /user_saved_chords/1.json
  def show
  end

  # GET /user_saved_chords/new
  def new
    @user_saved_chord = UserSavedChord.new
  end

  # GET /user_saved_chords/1/edit
  def edit
  end

  # POST /user_saved_chords
  # POST /user_saved_chords.json
  def create
    if request.xhr?
      formatted_params = params[:save_chords].split(",")[1..-1].map!{|chord| chord.strip}
      p formatted_params
      chord_ids = formatted_params.map{|chord| Chord.find_by(escaped_name: chord.strip).id}

      chord_ids.each do |id|
        UserSavedChord.find_or_create_by(user_id: session[:user_id], chord_id: id)
        p id
      end
    end
  end

  # PATCH/PUT /user_saved_chords/1
  # PATCH/PUT /user_saved_chords/1.json
  def update
    respond_to do |format|
      if @user_saved_chord.update(user_saved_chord_params)
        format.html { redirect_to @user_saved_chord, notice: 'User saved chord was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_saved_chord }
      else
        format.html { render :edit }
        format.json { render json: @user_saved_chord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_saved_chords/1
  # DELETE /user_saved_chords/1.json
  def destroy
    p params
    @user_saved_chord.destroy
    @user = User.find(session[:user_id])
    @saved_chords = @user.user_saved_chords.map(&:chord)
    puts @saved_chords
    # respond_to do |format|
    #   format.html { redirect_to user_saved_chords_url, notice: 'User saved chord was successfully destroyed.' }
    #   format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_saved_chord
      @user_saved_chord = UserSavedChord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_saved_chord_params
      params.require(:user_saved_chord).permit(:user_id, :chord_id)
    end
end
