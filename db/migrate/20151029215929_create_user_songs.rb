class CreateUserSongs < ActiveRecord::Migration
  def change
    create_table :user_songs do |t|
      t.integer :difficulty
      t.boolean :saved
      t.integer :user_id
      t.integer :song_id

      t.timestamps null: false
    end
  end
end
