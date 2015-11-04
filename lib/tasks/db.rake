namespace :db do
  desc "Loads a subset of our database"
  task small_seeds: :environment do
    artist_files = Dir.glob('db/artists/*/*.txt')
    artist_files = artist_files[0...100]
    artist_files.each do |artist_file|
      File.foreach(artist_file) do |song_json|
        song_data = JSON.parse(song_json)
        artist = song_data["artist"].strip
        title  = song_data["title"].strip
        p "#{artist} - #{title}"

        tab_create_hash = {
          :domain       => song_data["url"].scan(/(?<=\.).*(?=\.com)/).first,
          :view_count   => song_data["ult_guitar_viewcount"].scan(/\d+/).first,
          :review_count => song_data["ult_guitar_reviewcount"].scan(/\d+/).first,
          :sequence     => Array.new(song_data["chords"]),
          :ranking      => song_data["ranking"],
          :url          => song_data["url"]
        }

        tab = Tab.new(tab_create_hash)
        if tab.save
          song = Song.find_or_create_by(artist: artist, title: title)
          tab.song = song
          tab.save

          tab.sequence.uniq.each do |chord_in_song|
            chord = Chord.find_by(name: chord_in_song.strip)
            IncludedChord.create(chord: chord, tab: tab)
          end
        else
          puts "Contains improper cords"
        end
      end
    end
  end
end
