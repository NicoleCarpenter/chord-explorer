class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song

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
