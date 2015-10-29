class CreateIncludedChords < ActiveRecord::Migration
  def change
    create_table :included_chords do |t|
      t.references :chord
      t.references :tab

      t.timestamps null: false
    end
  end
end
