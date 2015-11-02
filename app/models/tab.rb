class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song

  def self.search(params)
      puts "Hello you came here via JS"
      params[:search]
        formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
        chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip)}

        array = Array.new(Chord.count, "0")
        chord_objects.each { |el| array[el.id] = "1" }
        your_chords = array.join("")

        tabs = self.playables(your_chords)

        @matching_songs = tabs.map(&:song)

  end

  def show_chords
    included_chords.map(&:chord).map(&:name)
  end

  def playable?(song_chords, your_chords)
    # Arguments will be strings of binary, representing booleans.
    (song_chords.to_i(2) & your_chords.to_i(2) == song_chords.to_i(2))
  end

  def self.playables(your_chords)
    all.select {|tab| tab.playable?(tab.binary_chords, your_chords)}
  end
end
