class WelcomeController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    #change @songs to an array of returned songs once we know how the search is working
    @songs = Song.all

    if params[:search]
      chord_objects = params[:search].split(",").map{|chord| Chord.find_by(name: chord.strip)}

      @matching_songs = Song.all.select{|song| chord_objects.to_set.superset?(song.included_chords.map(&:chord).to_set)}


      # @chords =
      # Chord.find_by(name: params[:search])
      # .order("created_at DESC")
      # Chord.search(params[:search]).order("created_at DESC")
    end

  end

end
