json.array!(@included_chords) do |included_chord|
  json.extract! included_chord, :id, :chord_id, :tab_id
  json.url included_chord_url(included_chord, format: :json)
end
