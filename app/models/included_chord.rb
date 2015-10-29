class IncludedChord < ActiveRecord::Base
  belongs_to  :chord
  belongs_to  :tab
end
