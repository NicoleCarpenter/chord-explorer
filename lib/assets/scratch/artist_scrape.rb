require 'nokogiri'
require 'anemone'
require_relative 'html_white_space_cleaner'

class ArtistSongCrawler

  #input is an array of urls for paginated songs by artist e.g. www.ultimate-guitar.com/tabs/adelete_tabs2.htm, www.ultimate-guitar.com/tabs/adelete_tabs3.htm
  def initialize(artist_song_list_pages)
    @song_list = artist_song_list_pages.map do |artist_song_list_page|
      find_rated_songs(artist_song_list_page)
    end
    @song_list.flatten!
    puts "Found these songs: #{@song_list}"
    @song_list.each do |song_url|
      puts "Navigating to #{song_url}"
      p UltimateNokoParser.parse(fetch!(song_url))
    end
  end

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

end

module UltimateNokoParser
  def self.parse(noko_object)
    song_data = {
      chords: get_chords(noko_object),
      title: get_title(noko_object),
      artist: get_artist(noko_object),
      ranking: get_ranking(noko_object),
      contributor: get_contributor(noko_object)
    }
  end

  def self.get_chords(noko_object)
    chords = []
    noko_object.css("pre span").children.each do |span|
      chords << span.text
    end
    chords
  end

  def self.get_title(noko_object)
    noko_object.css("h1").text[0..-8]
  end

  def self.get_artist(noko_object)
    noko_object.css(".t_autor a").text
  end

  def self.get_ranking(noko_object)
    noko_object.css(".vote-success").text
  end

  def self.get_contributor(noko_object)
    noko_object.css(".t_dtde").text
  end
end

module Fetcher
  def self.get_em(file_name)
    link_list = parse_file(file_name)
    link_list.map! {|link| focus(link)}
    link_list.flatten!.reject! {|link| link.include?("htm?sort=date")}.map! {|link| link.sub(/s/, "")}
  end

  def self.parse_file(file_name)
    link_list = []
    file = File.open(file_name,"r")
    file.each_line {|line| link_list << line[0..-2]}
    file.close
    link_list
  end

  def self.focus(artist_link)
    pagination_links = []
    variant = artist_link[0..-4]
    Anemone.crawl(artist_link) do |anemone|
      anemone.focus_crawl do |page|
        page.links.select do |link|
          link.to_s.match(/#{variant}/)
        end
      end
      anemone.on_every_page do |page|
        pagination_links << page.url
      end
    end
    pagination_links.map! {|link| link.to_s}
  end
end

#For each link provided via Fetcher.get_em
#Visit each link and grab appropriate links to songs and put into array
#Deliver list of songs to ArtistCrawler



