class UserSavedChord < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :chord
end
