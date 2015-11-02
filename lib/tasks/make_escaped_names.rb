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
