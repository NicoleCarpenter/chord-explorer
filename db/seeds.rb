user = User.create(username:"Andy", password_digest:"password")

chord = Chord.create(name:"Em", display_card:"chordEm.jpg", family:"Minor", frequency:"9")

song = Song.create(title:"Stairway to Heaven", artist:"Led Zeppelin")

tab = Tab.create(url:"www.tab.com", rating:"4", click_count:"23", raw_html:"blah blah blah", song_id:1)

userSavedChord = UserSavedChord.create(user_id:1, chord_id:1)

userSong = UserSong.create(difficulty:3, saved:true, user_id:1, song_id:1)

includedChord = IncludedChord.create(chord_id:1, tab_id:1)

