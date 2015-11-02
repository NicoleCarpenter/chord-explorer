require_relative 'artist_scrape'

  def find_rated_songs(artist_song_page)
    noko = fetch!(artist_song_page)
    well_rated = noko.css(".r_5") + noko.css(".r_4")
    well_rated_links = well_rated.map do |node|
      link = node.parent.parent.css("a").attribute("href").value
      if link.match(/._crd.htm/) && link.match(/plus\.ultimate-guitar|_ukulele_crd/) == nil
        link
      end
    end
    well_rated_links.compact
  end


  def fetch!(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port) #create a new HTTP request
    request = Net::HTTP::Get.new(uri.request_uri) #create a get request
    request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36"}) #set headers
    response = http.request(request) #make the request
    clean_html_string = HTMLWhitespaceCleaner.clean(response.body)
    noko_object =  Nokogiri.parse(clean_html_string)
  end


drone = ArtistSongCrawler.new(["http://www.ultimate-guitar.com/tabs/okkervil_river_tabs.htm", "http://www.ultimate-guitar.com/tabs/okkervil_river_tabs2.htm"])
