require 'json'
Dir.chdir('db')
chord_list = File.open("chord_list.txt", "r").readlines
chord_list.each do |line|
  name, code = line.chomp.split(",")
  chord = Chord.find_or_create_by(name: name, code: code, family: name[0])
end

proper_chords = Chord.all.pluck(:name)

# #create user objects
# 20.times do
#   user = User.create(username: Faker::Name.first_name,
#                     password:"password")
# end

# #creates associations between all our objects
# truth = [true, false]
# 50.times do
#   userSavedChord = UserSavedChord.create(user_id: User.all.sample.id, chord_id: Chord.all.sample.id)
#   userSong = Song.all.sample.user_songs.create(difficulty: Faker::Number.between(1, 5),
#                                               saved: truth.sample,
#                                               user_id: User.all.sample.id)

#   includedChord = Chord.all.sample.included_chords.create(tab_id: Tab.all.sample.id)
# end


# A script for getting JSON objects into our database.

# artist_files = Dir.glob('db/artists/*/*.txt')

# artist_files.each do |artist_file|
#   File.foreach(artist_file) do |song_json|
#     song_data = JSON.parse(song_json)
#     artist = song_data["artist"].strip
#     title  = song_data["title"].strip
#     p "#{artist} - #{title}"

#     tab_create_hash = {
#       :domain       => song_data["url"].scan(/(?<=\.).*(?=\.com)/).first,
#       :view_count   => song_data["ult_guitar_viewcount"].scan(/\d+/).first,
#       :review_count => song_data["ult_guitar_reviewcount"].scan(/\d+/).first,
#       :sequence     => Array.new(song_data["chords"]),
#       :ranking      => song_data["ranking"],
#       :url          => song_data["url"]
#     }

#     tab = Tab.new(tab_create_hash)
#     if tab.save
#       song = Song.find_or_create_by(artist: artist, title: title)
#       tab.song = song
#       tab.save

#       tab.sequence.uniq.each do |chord_in_song|
#         chord = Chord.find_by(name: chord_in_song.strip)
#         IncludedChord.create(chord: chord, tab: tab)
#       end
#     else
#       puts "Contains improper cords"
#     end
#   end
# end

puts "Adding frequency data to chords table"

freq_dist = Chord.freq_dist

freq_dist.each do |chord_name, frequency|
  chord = Chord.find_by(name: chord_name)
  chord.frequency = frequency
  chord.save
end

# cutoff = 3

# puts "Deleting chords with frequency less than #{cutoff}"
# puts "Current chord count: #{Chord.count}. Current tab count: #{Tab.count}"

# loser_chords = Chord.where("frequency < ?", cutoff)
# loser_chords.destroy_all

# # Sniping some typo chords...

# Chord.where("name LIKE '%H%'").destroy_all

# # Killing off tabs which have only one chord

# # A hash, keys are tab_ids, values are the amount of chords in them.
# chords_per_song = IncludedChord.group("chord_id").count("chord_id")
# chords_per_song.select { |key, value| value == 1}
# Tab.find(chords_per_song.keys).destroy_all

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
