json.array!(@chords) do |chord|
  json.extract! chord, :id, :name, :display_card, :family, :frequency
  json.url chord_url(chord, format: :json)
end
