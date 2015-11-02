class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song

  def self.search(params)
      puts "Hello you came here via JS"
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip).id}
      tabs = Tab.find_all_for_chords(chord_objects)
      tabs = Tab.playables(your_chords)
      @matching_songs = tabs.map(&:song)
    end
  def self.find_all_for_chords(chord_ids)
    joins(:included_chords).
      where(tab_id: chord_ids).
      where.not(tab_id: IncludedChord.without(chord_ids).select(:tab_id))
      # where("included_chords.tab_id NOT IN (#{IncludedChord.without(chord_ids).select(:tab_id).to_sql})")
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
