class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song

  def show_chords
    included_chords.map(&:chord).map(&:name)
  end

end
