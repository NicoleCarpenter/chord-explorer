class AddIndexToIncludedChordsTabId < ActiveRecord::Migration
  def change
    add_index :included_chords, :tab_id
  end
end
