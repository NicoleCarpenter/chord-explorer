class CreateIncludedChords < ActiveRecord::Migration
  def change
    create_table :included_chords do |t|
      t.integer :chord_id
      t.integer :tab_id

      t.timestamps null: false
    end
  end
end
