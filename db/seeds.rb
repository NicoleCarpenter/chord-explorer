user = User.create(username:"Andy", password_digest:"password")

chord = Chord.create(name:"Em", display_card:"chordEm.jpg", family:"Minor", frequency:"9")

song = Song.create(title:"Stairway to Heaven", artist:"Led Zeppelin")

tab = Tab.create(url:"www.tab.com", rating:"4", click_count:"23", raw_html:"blah blah blah", song_id:1)

userSavedChord = UserSavedChord.create(user_id:1, chord_id:1)

userSong = UserSong.create(difficulty:3, saved:true, user_id:1, song_id:1)

includedChord = IncludedChord.create(chord_id:1, tab_id:1)


chords = ["A", "B", "C", "D", "E", "F", "G",
          "Am", "Bm", "Cm", "Dm", "Em", "Fm", "Gm",
          "A7", "B7", "C7", "D7", "E7", "F7", "G7",

          "Ab", "Bb", "Cb", "Db", "Eb", "Fb", "Gb",
          "Abm", "Bbm", "Cbm", "Dbm", "Ebm", "Fbm", "Gbm",
          "Ab7", "Bb7", "Cb7", "Db7", "Eb7", "Fb7", "Gb7",

          "A#", "B#", "C#", "D#", "E#", "F#", "G#",
          "A#m", "B#m", "C#m", "D#m", "E#m", "F#m", "G#m",
          "A#7", "B#7", "C#7", "D#7", "E#7", "F#7", "G#7"]

families = ["major", "minor", "seventh"]

truth = [true, false]

20.times do
  user = User.create(username: Faker::Name.first_name,
                    password_digest:"password")

  chord = Chord.create(name: chords.sample,
                      display_card:"display_url.jpg",
                      family: families.sample,
                      frequency: Faker::Number.between(1, 5000))

  song = Song.create(title: Faker::Company.buzzword,
                    artist: Faker::Company.name)

  tab = Song.all.sample.tabs.create(url:"www.tab.com",
                  rating: Faker::Number.between(1, 5),
                  click_count: Faker::Number.between(1, 5000),
                  raw_html:"blah blah blah")
end

50.times do
userSavedChord = UserSavedChord.create(user_id:1, chord_id:1)

userSong = Song.all.sample.usersongs.create(difficulty: Faker::Number.between(1, 5),
                                            saved: truth.sample,
                                            user_id: User.all.sample)

includedChord = Chord.all.sample.includedchords.create(tab_id: Tab.all.sample)
end
