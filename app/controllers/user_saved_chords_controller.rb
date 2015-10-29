class UserSavedChordsController < ApplicationController
  before_action :set_user_saved_chord, only: [:show, :edit, :update, :destroy]

  # GET /user_saved_chords
  # GET /user_saved_chords.json
  def index
    @user_saved_chords = UserSavedChord.all
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
    @user_saved_chord = UserSavedChord.new(user_saved_chord_params)

    respond_to do |format|
      if @user_saved_chord.save
        format.html { redirect_to @user_saved_chord, notice: 'User saved chord was successfully created.' }
        format.json { render :show, status: :created, location: @user_saved_chord }
      else
        format.html { render :new }
        format.json { render json: @user_saved_chord.errors, status: :unprocessable_entity }
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
    @user_saved_chord.destroy
    respond_to do |format|
      format.html { redirect_to user_saved_chords_url, notice: 'User saved chord was successfully destroyed.' }
      format.json { head :no_content }
    end
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
