require 'json'

# Parsing the guitar-party tabs. Inside ./guitarparty-tabs is a series of text files, containing JSON objects. So the first job is to open each of these in turn, parse them as JSON, and then extract the data we want.

Dir.glob("db/guitarparty-tabs/*.txt") do |tab_file|
  next if tab_file == '.' or tab_file == '..' or tab_file == ".DS_Store"
  p "Work on #{tab_file}"
  raw_tab = File.open(tab_file).read
  tab_parsed = JSON.parse(raw_tab)

  # Unfortunately there are can be many artists on one song, so I've decided to just select the first.
  song = Song.find_or_create_by(artist: tab_parsed["authors"][0]["name"], title: tab_parsed["title"])

  tab = Tab.create(song: song, url: tab_parsed["permalink"], domain: "guitarparty", raw_html: tab_parsed["body"])
  tab_parsed["chords"].each do |chord_in_song|
    if !chord_in_song["name"].match("not exist")
      chord = Chord.find_or_create_by(name: chord_in_song["name"], code: chord_in_song["code"], family: chord_in_song["name"][0])
    # In order to get the image, we've gotta do some scraping here. This is what the chord info looks like:
    # {"objects": [{"code": "xo221o", "image_url": "http://chords.guitarparty.com/chord-images/guitar_Am_xo221o.png", "instrument": {"name": "Guitar", "safe_name": "guitar", "tuning": "EADGBE"}, "name": "Am", "uri": "/v2/chords/46345/"}], "objects_count": 1}
      IncludedChord.create(chord: chord, tab: tab)
    end
  end
end

#create user objects
20.times do
  user = User.create(username: Faker::Name.first_name,
                    password:"password")
end

#creates associations between all our objects
truth = [true, false]
50.times do
  userSavedChord = UserSavedChord.create(user_id: User.all.sample.id, chord_id: Chord.all.sample.id)
  userSong = Song.all.sample.user_songs.create(difficulty: Faker::Number.between(1, 5),
                                              saved: truth.sample,
                                              user_id: User.all.sample.id)

  includedChord = Chord.all.sample.included_chords.create(tab_id: Tab.all.sample.id)
end


# A script for getting JSON objects into our database.

artist_files = Dir.glob('db/artists/*/*.txt')

artist_files.each do |artist_file|
  File.foreach(artist_file) do |song_json|
    song_data = JSON.parse(song_json)
    artist = song_data["artist"].strip
    title  = song_data["title"].strip
    p "#{artist} - #{title}"
    
    song = Song.find_or_create_by(artist: artist, title: title)

    tab_create_hash = {
      :song         => song,
      :domain       => song_data["url"].scan(/(?<=\.).*(?=\.com)/).first,
      :view_count   => song_data["ult_guitar_viewcount"].scan(/\d+/).first,
      :review_count => song_data["ult_guitar_reviewcount"].scan(/\d+/).first,
      :sequence     => Array.new(song_data["chords"]),
      :ranking      => song_data["ranking"],
      :url          => song_data["url"]
    }

    tab = Tab.new(tab_create_hash)
    tab.save
    tab.sequence.uniq.each do |chord_in_song|
      chord = Chord.find_or_create_by(name: chord_in_song.strip)
      IncludedChord.create(chord: chord, tab: tab)
    end
  end
end

puts "Adding frequency data to chords table"

freq_dist = Chord.freq_dist

freq_dist.each do |chord_name, frequency|
  chord = Chord.find_by(name: chord_name)
  chord.frequency = frequency
  chord.save
end

cutoff = 2

puts "Deleting chords with frequency less than #{cutoff}"

Chord.where("frequency < ?", cutoff).destroy_all

puts "Escaping sharps and slashes now..."

# this populates the "escaped_name" column for all chords, which is important for the javascript and jquery in the well logic
chords = Chord.all

chords.each do |chord|
  if chord.name.include?("#")
    chord.escaped_name = chord.name.gsub(/#/, "sharp")
  else
    chord.escaped_name = chord.name
  end
  chord.save
end

chords.each do |chord|
  if chord.name.include?("/")
    chord.escaped_name = chord.escaped_name.gsub(/\//, "slash")
  else
    chord.escaped_name = chord.escaped_name
  end
  chord.save
end