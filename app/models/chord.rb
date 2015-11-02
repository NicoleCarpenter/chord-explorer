class Chord < ActiveRecord::Base
  has_many    :user_saved_chords
  has_many    :included_chords, dependent: :destroy
  has_many    :tabs, through: :included_chords
  has_many    :songs, through: :tabs

  # def self.search(search)
  #   where("name = ?", "#{search}")
  # end
  #
  #
  def render_chord
    "<div class='chord' data-code='#{self.code}' data-name='#{self.name}'></div>"
  end

  def self.freq_dist
    # returns a hash with keys, values == chord name, frequency within database
    IncludedChord.joins(:chord).group("chords.name").order("count_chord_id desc").count("chord_id")
  end

end
