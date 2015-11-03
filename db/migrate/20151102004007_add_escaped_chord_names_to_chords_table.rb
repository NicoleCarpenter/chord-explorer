class AddEscapedChordNamesToChordsTable < ActiveRecord::Migration
  def change
    add_column :chords, :escaped_name, :string
  end
end
