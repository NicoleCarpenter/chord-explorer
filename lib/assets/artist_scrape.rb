require 'nokogiri'
require 'anemone'
require_relative 'ultimate_noko_parser'
require_relative 'html_white_space_cleaner'

class ArtistSongCrawler

  #input is an array of urls for paginated songs by artist e.g. www.ultimate-guitar.com/tabs/adelete_tabs2.htm, www.ultimate-guitar.com/tabs/adelete_tabs3.htm
  def initialize(artist_song_list_pages)
    @song_list = artist_song_list_pages.map do |artist_song_list_page|
      puts "Crawling #{artist_song_list_page}"
      find_rated_songs(artist_song_list_page)
    end
    @song_list.flatten!
    @song_list.each do |song_url|
      puts "Navigating to #{song_url}"
      clean_html = fetch!(song_url)
      noko = make_noko(clean_html)
      UltimateNokoParser.parse(noko_object=noko, song_url = song_url)
      sleep(2)
    end
  end

  def find_rated_songs(artist_song_page)
    clean_html = fetch!(artist_song_page)
    noko = make_noko(clean_html)
    well_rated = noko.css(".r_5") + noko.css(".r_4")
    well_rated_links = well_rated.map do |node|
      link = node.parent.parent.css("a").attribute("href").value
      if link.match(/._crd.htm/) && link.match(/plus\.ultimate-guitar|_ukulele_crd|album_crd/) == nil
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
  end

  def make_noko(clean_html_string)
    noko_object = Nokogiri.parse(clean_html_string)
  end

end
