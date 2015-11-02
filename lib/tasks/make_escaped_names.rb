chords = Chord.all

chords.each do |chord|
  if chord.name.include?("#")
    chord.escaped_name = chord.name.gsub(/#/, "\\\\\\#")
  else
    chord.escaped_name = chord.name
  end
  chord.save
end
