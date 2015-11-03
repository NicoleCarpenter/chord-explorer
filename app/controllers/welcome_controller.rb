class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
      @saved_chords = @user.user_saved_chords.map(&:chord).map(&:escaped_name)

    end


    @songs = Song.all
    @chords = Chord.all

    @achords = @chords.where(family: "A").order(frequency: :desc)
    @bchords = @chords.where(family: "B").order(frequency: :desc)
    @cchords = @chords.where(family: "C").order(frequency: :desc)
    @dchords = @chords.where(family: "D").order(frequency: :desc)
    @echords = @chords.where(family: "E").order(frequency: :desc)
    @fchords = @chords.where(family: "F").order(frequency: :desc)
    @gchords = @chords.where(family: "G").order(frequency: :desc)

    if params[:search]
      p params
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip)}
    end
  end
end
