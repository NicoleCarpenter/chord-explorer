class WelcomeController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
    end

    #change @songs to an array of returned songs once we know how the search is working
    @songs = Song.all
    @chords = Chord.all

    <div class="jumbotron">
  <div class="container centered">
    <span class='brand-font'>Chord Explorer</span>
    <%= link_to "Home", welcome_index_path %>
    <% if logged_in? %>
      <%= link_to "Log out", { controller: :sessions, action: :destroy, id: session[:user_id] }, method: :delete %>
    <% end %>

  </div>
</div>
    @bchords = @chords.where(family: "B")
    @cchords = @chords.where(family: "C")
    @dchords = @chords.where(family: "D")
    @echords = @chords.where(family: "E")
    @fchords = @chords.where(family: "F")
    @gchords = @chords.where(family: "G")

    if params[:search]
      formatted_params = params[:search].split(",")[2..-1]
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip)}

      array = Array.new(Chord.count, "0")
      chord_objects.each { |el| array[el.id] = "1" }
      your_chords = array.join("")

      tabs = Tab.all.select {|tab| tab.playable?(tab.binary_chords, your_chords)}

      @matching_songs = tabs.map(&:song)

    end

  end

end
