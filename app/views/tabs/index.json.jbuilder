json.array!(@tabs) do |tab|
  json.extract! tab, :id, :url, :rating, :click_count, :raw_html, :song_id
  json.url tab_url(tab, format: :json)
end
