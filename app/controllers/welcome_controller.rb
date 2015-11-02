class WelcomeController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    #change @songs to an array of returned songs once we know how the search is working
    @songs = Song.all

    if params[:search]
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip).id}

      tabs = Tab.find_all_for_chords(chord_objects)

      # p "chord_objects's length are #{chord_objects.count}"

      # array = Array.new(Chord.count, "0")
      # chord_objects.each { |el| array[el.id] = "1" }
      # your_chords = array.join("")

      # tabs = Tab.playables(your_chords)
      @matching_songs = tabs.map(&:song)
      # @matching_songs = Song.all.select{|song| chord_objects.to_set.superset?(song.included_chords.map(&:chord).to_set)}
    end

  end

end
