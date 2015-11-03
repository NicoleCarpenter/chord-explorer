class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    @songs = Song.all
    @chords = Chord.all

    @achords = @chords.where(family: "A")
    @bchords = @chords.where(family: "B")
    @cchords = @chords.where(family: "C")
    @dchords = @chords.where(family: "D")
    @echords = @chords.where(family: "E")
    @fchords = @chords.where(family: "F")
    @gchords = @chords.where(family: "G")

    if params[:search]
      p params
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip)}
    end

end
