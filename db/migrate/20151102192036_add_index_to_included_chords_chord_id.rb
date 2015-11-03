class AddIndexToIncludedChordsChordId < ActiveRecord::Migration
  def change
    add_index :included_chords, :chord_id
  end
end
