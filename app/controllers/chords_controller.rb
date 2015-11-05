class ChordsController < ApplicationController
  before_action :set_chord, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  FAMILIES = ["A", "B", "C", "D", "E", "F"]
  # GET /chords
  # GET /chords.json
  def index
    if request.xhr?
      @chords = Chord.order(:name)

      @achords = @chords.where(family: "A").order(frequency: :desc)
      @bchords = @chords.where(family: "B").order(frequency: :desc)
      @cchords = @chords.where(family: "C").order(frequency: :desc)
      @dchords = @chords.where(family: "D").order(frequency: :desc)
      @echords = @chords.where(family: "E").order(frequency: :desc)
      @fchords = @chords.where(family: "F").order(frequency: :desc)
      @gchords = @chords.where(family: "G").order(frequency: :desc)

      respond_to do |format|
        format.html { render partial: 'index'}
      end

    end
  end

  # GET /chords/1
  # GET /chords/1.json
  def show
  end

  # GET /chords/new
  def new
    @chord = Chord.new
  end

  # GET /chords/1/edit
  def edit
  end

  # POST /chords
  # POST /chords.json
  def create
    @chord = Chord.new(chord_params)

    respond_to do |format|
      if @chord.save
        format.html { redirect_to @chord, notice: 'Chord was successfully created.' }
        format.json { render :show, status: :created, location: @chord }
      else
        format.html { render :new }
        format.json { render json: @chord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chords/1
  # PATCH/PUT /chords/1.json
  def update
    respond_to do |format|
      if @chord.update(chord_params)
        format.html { redirect_to @chord, notice: 'Chord was successfully updated.' }
        format.json { render :show, status: :ok, location: @chord }
      else
        format.html { render :edit }
        format.json { render json: @chord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chords/1
  # DELETE /chords/1.json
  def destroy
    @chord.destroy
    respond_to do |format|
      format.html { redirect_to chords_url, notice: 'Chord was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chord
      @chord = Chord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chord_params
      params.require(:chord).permit(:name, :display_card, :family, :frequency)
    end
end
