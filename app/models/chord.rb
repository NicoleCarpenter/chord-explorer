class Chord < ActiveRecord::Base
  has_many    :user_saved_chords
  has_many    :included_chords
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

end
