class WelcomeController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    #change @songs to an array of returned songs once we know how the search is working
    @songs = Song.all
    @chords = Chord.all

    if params[:search]
      chord_objects = params[:search].split(",").map{|chord| Chord.find_by(name: chord.strip)}

      array = Array.new(Chord.count, "0")
      chord_objects.each { |el| array[el.id] = "1" }
      your_chords = array.join("")

      tabs = Tab.all.select {|tab| tab.playable?(tab.binary_chords, your_chords)}
      @matching_songs = tabs.map(&:song)
      # @matching_songs = Song.all.select{|song| chord_objects.to_set.superset?(song.included_chords.map(&:chord).to_set)}
    end

  end

end
