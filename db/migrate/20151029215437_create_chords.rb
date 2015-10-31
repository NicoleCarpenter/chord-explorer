class CreateChords < ActiveRecord::Migration
  def change
    create_table :chords do |t|
      t.string :name
      # t.string :display_card # we replace this with render_chord method in model
      t.string :family
      t.integer :frequency
      t.string :code

      t.timestamps null: false
    end
  end
end
