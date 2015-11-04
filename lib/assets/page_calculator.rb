# A little script that mapped heavy_hitters.yaml into the artist_links format we prefer. 78 was chosen as an arbitrary cutoff.

result = hitters[0..78].map do |x, y|
    page_count = (y / 100) + 1
    (1..page_count).map {|i| "http://www.ultimate-guitar.com#{x}#{i}.htm"}
end