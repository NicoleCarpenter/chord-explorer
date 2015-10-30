require 'json'

user = User.create(username:"Andy", password_digest:"password")

chord = Chord.create(name:"Em", display_card:"chordEm.jpg", family:"Minor", frequency:"9")

song = Song.create(title:"Stairway to Heaven", artist:"Led Zeppelin")

tab = Tab.create(url:"www.tab.com", rating:"4", click_count:"23", raw_html:"blah blah blah", song_id:1)

userSavedChord = UserSavedChord.create(user_id:1, chord_id:1)

userSong = UserSong.create(difficulty:3, saved:true, user_id:1, song_id:1)

includedChord = IncludedChord.create(chord_id:1, tab_id:1)

# Parsing the guitar-party tabs. Inside ./guitarparty-tabs is a series of text files, containing JSON objects. So the first job is to open each of these in turn, parse them as JSON, and then extract the data we want.

Dir.foreach("guitarparty-tabs") do |tab_file|
  raw_tab = File.open(tab_file).read
  tab = JSON.parse(raw_tab)

  # Unfortunately there are can be many artists on one song, so I've decided to just select the first.
  song = Song.find_or_create_by(artist: tab["artist"][0]["name"], title: tab["title"])

  tab = Tab.create(song: song, url: tab["permalink"], text: tab["body"])

  chords_in_song = tab["chords"].map { |chord_hash| chord_hash["name"] }
  chords_in_song.each do |chord_in_song|
    chord = Chord.find_or_create_by(name: chord_in_song)
    # In order to get the image, we've gotta do some scraping here. This is what the chord info looks like:
    # {"objects": [{"code": "xo221o", "image_url": "http://chords.guitarparty.com/chord-images/guitar_Am_xo221o.png", "instrument": {"name": "Guitar", "safe_name": "guitar", "tuning": "EADGBE"}, "name": "Am", "uri": "/v2/chords/46345/"}], "objects_count": 1}
    IncludedChord.create(chord: chord, tab: tab)
  end
end
