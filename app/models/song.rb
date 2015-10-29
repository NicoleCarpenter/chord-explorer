class Song < ActiveRecord::Base
  has_many    :user_songs
  has_many    :tabs
  has_many    :included_chords, through: :tabs
  has_many    :chords, through: :included_chords
end
