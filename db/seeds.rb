require 'json'

# #list of basic chords for seeding.
# major = ["A", "B", "C", "D", "E", "F", "G",
#           "Ab", "Bb", "Cb", "Db", "Eb", "Fb", "Gb",
#           "A#", "B#", "C#", "D#", "E#", "F#", "G#"]
# minor = ["Am", "Bm", "Cm", "Dm", "Em", "Fm", "Gm",
#           "A#m", "B#m", "C#m", "D#m", "E#m", "F#m", "G#m",
#           "Abm", "Bbm", "Cbm", "Dbm", "Ebm", "Fbm", "Gbm"]
# seventh = ["A7", "B7", "C7", "D7", "E7", "F7", "G7",
#           "Ab7", "Bb7", "Cb7", "Db7", "Eb7", "Fb7", "Gb7",
#           "A#7", "B#7", "C#7", "D#7", "E#7", "F#7", "G#7"]
#
# #creates chord objects
# major.each do |chord|
#   newchord = Chord.create(name: chord,
#                           display_card:"display_" + chord + ".jpg",
#                           family: "major",
#                           frequency: Faker::Number.between(1, 5000))
# end
#
# minor.each do |chord|
#   newchord = Chord.create(name: chord,
#                           display_card:"display_" + chord + ".jpg",
#                           family: "minor",
#                           frequency: Faker::Number.between(1, 5000))
# end
#
# seventh.each do |chord|
#   newchord = Chord.create(name: chord,
#                           display_card:"display_" + chord + ".jpg",
#                           family: "seventh",
#                           frequency: Faker::Number.between(1, 5000))
# end


# Parsing the guitar-party tabs. Inside ./guitarparty-tabs is a series of text files, containing JSON objects. So the first job is to open each of these in turn, parse them as JSON, and then extract the data we want.
Dir.chdir("db/guitarparty-tabs")
Dir.foreach(".") do |tab_file|
  next if tab_file == '.' or tab_file == '..' or tab_file == ".DS_Store"
  p "Work on #{tab_file}"
  raw_tab = File.open(tab_file).read
  tab_parsed = JSON.parse(raw_tab)

  # Unfortunately there are can be many artists on one song, so I've decided to just select the first.
  song = Song.find_or_create_by(artist: tab_parsed["authors"][0]["name"], title: tab_parsed["title"])

  tab = Tab.create(song: song, url: tab_parsed["permalink"], domain: tab_parsed["permalink"].scan(/.*?.com/), raw_html: tab_parsed["body"])
  tab_parsed["chords"].each do |chord_in_song|
    chord = Chord.find_or_create_by(name: chord_in_song["name"], code: chord_in_song["code"], family: chord_in_song["name"][0])
    # In order to get the image, we've gotta do some scraping here. This is what the chord info looks like:
    # {"objects": [{"code": "xo221o", "image_url": "http://chords.guitarparty.com/chord-images/guitar_Am_xo221o.png", "instrument": {"name": "Guitar", "safe_name": "guitar", "tuning": "EADGBE"}, "name": "Am", "uri": "/v2/chords/46345/"}], "objects_count": 1}
    IncludedChord.create(chord: chord, tab: tab)
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

chord_count = Chord.count

Tab.all.each_with_index do |tab, i|
  p i
  array = Array.new(chord_count, "0")
  chords = tab.chords
  chords.each { |el| array[el.id] = "1" }
  tab.binary_chords = array.join("")
  tab.save
end



# song generator
# song = Song.create(title: Faker::Company.buzzword,
#                   artist: Faker::Company.name)

# tab generator
# tab = Song.all.sample.tabs.create(url:"www.tab.com",
#                   rating: Faker::Number.between(1, 5),
#                   click_count: Faker::Number.between(1, 5000),
#                   raw_html:"blah blah blah")

# single examples
# user = User.create(username:"Andy", password_digest:"password")
# tab = Tab.create(url:"www.tab.com", rating:"4", click_count:"23", raw_html:"blah blah blah", song_id:1)
# song = Song.create(title:"Stairway to Heaven", artist:"Led Zeppelin")
# chord = Chord.create(name:"Em", display_card:"chordEm.jpg", family:"Minor", frequency:"9")
# userSavedChord = UserSavedChord.create(user_id:1, chord_id:1)
# userSong = UserSong.create(difficulty:3, saved:true, user_id:1, song_id:1)
# includedChord = IncludedChord.create(chord_id:1, tab_id:1)
