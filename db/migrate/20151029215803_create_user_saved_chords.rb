class CreateUserSavedChords < ActiveRecord::Migration
  def change
    create_table :user_saved_chords do |t|
      t.references :user
      t.references :chord

      t.timestamps null: false
    end
  end
end
