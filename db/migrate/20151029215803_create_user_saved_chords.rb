class CreateUserSavedChords < ActiveRecord::Migration
  def change
    create_table :user_saved_chords do |t|
      t.integer :user_id
      t.integer :chord_id

      t.timestamps null: false
    end
  end
end
