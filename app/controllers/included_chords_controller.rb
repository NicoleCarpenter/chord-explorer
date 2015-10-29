class IncludedChordsController < ApplicationController
  before_action :set_included_chord, only: [:show, :edit, :update, :destroy]

  # GET /included_chords
  # GET /included_chords.json
  def index
    @included_chords = IncludedChord.all
  end

  # GET /included_chords/1
  # GET /included_chords/1.json
  def show
  end

  # GET /included_chords/new
  def new
    @included_chord = IncludedChord.new
  end

  # GET /included_chords/1/edit
  def edit
  end

  # POST /included_chords
  # POST /included_chords.json
  def create
    @included_chord = IncludedChord.new(included_chord_params)

    respond_to do |format|
      if @included_chord.save
        format.html { redirect_to @included_chord, notice: 'Included chord was successfully created.' }
        format.json { render :show, status: :created, location: @included_chord }
      else
        format.html { render :new }
        format.json { render json: @included_chord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /included_chords/1
  # PATCH/PUT /included_chords/1.json
  def update
    respond_to do |format|
      if @included_chord.update(included_chord_params)
        format.html { redirect_to @included_chord, notice: 'Included chord was successfully updated.' }
        format.json { render :show, status: :ok, location: @included_chord }
      else
        format.html { render :edit }
        format.json { render json: @included_chord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /included_chords/1
  # DELETE /included_chords/1.json
  def destroy
    @included_chord.destroy
    respond_to do |format|
      format.html { redirect_to included_chords_url, notice: 'Included chord was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_included_chord
      @included_chord = IncludedChord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def included_chord_params
      params.require(:included_chord).permit(:chord_id, :tab_id)
    end
end
