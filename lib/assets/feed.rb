# A script for getting JSON objects into our database.
require 'json'

artist_files = Dir.glob('db/artists/*/*.txt')

artist_files.each do |artist_file|
  File.foreach(artist_file) do |song_json|
    song_data = JSON.parse(song_json)

    tab_create_hash = {
      :artist       => song_data["artist"].strip,
      :title        => song_data["title"].strip,
      :domain       => song_data["url"].scan(/(?<=\.).*(?=\.com)/).first,
      :view_count   => song_data["ult_guitar_viewcount"].scan(/\d+/).first,
      :review_count => song_data["ult_guitar_reviewcount"].scan(/\d+/).first,
      :sequence     => song_data["chords"],
      :ranking      => song_data["ranking"],
      :url          => song_data["url"]
    }

    song = Song.find_or_create_by(artist: tab_create_hash[:artist], title: tab_create_hash[:title])

    tab = Tab.find_or_create_by(tab_create_hash)
    tab.sequence.uniq.each do |chord_in_song|
      chord = Chord.find_or_create_by(name: chord_in_song["name"])
      IncludedChord.create(chord: chord, tab: tab)
    end
  end
end