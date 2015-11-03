class WelcomeController < ApplicationController
  respond_to :html, :js

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    @saved_chords = @user.user_saved_chords.map(&:chord).map(&:escaped_name)

    @songs = Song.all
    @chords = Chord.all

    @achords = @chords.where(family: "A")
    @bchords = @chords.where(family: "B")
    @cchords = @chords.where(family: "C")
    @dchords = @chords.where(family: "D")
    @echords = @chords.where(family: "E")
    @fchords = @chords.where(family: "F")
    @gchords = @chords.where(family: "G")

# <<<<<<< HEAD
# =======
#     if params[:search]
#       formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
#       chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip).id}
#       tabs = Tab.find_all_for_chords(chord_objects)
#       @matching_songs = tabs.map(&:song)

#     end

# >>>>>>> master
  end

end
