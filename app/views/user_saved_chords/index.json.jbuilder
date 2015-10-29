json.array!(@user_saved_chords) do |user_saved_chord|
  json.extract! user_saved_chord, :id, :user_id, :chord_id
  json.url user_saved_chord_url(user_saved_chord, format: :json)
end
