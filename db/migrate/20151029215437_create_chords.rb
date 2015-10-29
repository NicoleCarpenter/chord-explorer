class CreateChords < ActiveRecord::Migration
  def change
    create_table :chords do |t|
      t.string :name
      t.string :display_card
      t.string :family
      t.integer :frequency

      t.timestamps null: false
    end
  end
end
