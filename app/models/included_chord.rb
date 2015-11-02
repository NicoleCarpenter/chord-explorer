class IncludedChord < ActiveRecord::Base
  belongs_to  :chord
  belongs_to  :tab

  def self.without(chord_ids)
    where('included_chords.tab_id NOT IN (?)', chord_ids)
  end
end
