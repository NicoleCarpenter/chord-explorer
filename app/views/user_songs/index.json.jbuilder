json.array!(@user_songs) do |user_song|
  json.extract! user_song, :id, :difficulty, :saved, :user_id, :song_id
  json.url user_song_url(user_song, format: :json)
end
