#Use nokogiri to navigate to https://www.ultimate-guitar.com/top/top100.htm
#Scrape html from the site and pull all the links.
#Use nokogiri to navigate to each page.
#Scrape the chords

module HTMLWhitespaceCleaner
  def self.clean(html_string)
    remove_all_white_space_between_tags(condense_whitespace(html_string)).strip
  end

  private
  WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

  def self.remove_all_white_space_between_tags(html_string)
    html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end
end

require 'net/http'
require 'nokogiri'
require 'open-uri'

class Page
  attr_accessor :links, :url, :noko_object, :clean_html_string

  def initialize(url)
    @url = url
    @noko_object = fetch!
    @clean_html_string
    @links = []
  end

  def fetch!
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port) #create a new HTTP request
    request = Net::HTTP::Get.new(uri.request_uri) #create a get request
    request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36"}) #set headers
    response = http.request(request) #make the request
    self.clean_html_string = HTMLWhitespaceCleaner.clean(response.body)
    self.noko_object =  Nokogiri.parse(clean_html_string)
  end

  def get_links(reg_exp)
   all_links =  self.noko_object.css('a').select {|node| node.attributes['href'].class !=NilClass}
   all_links.map! {|node| node.attributes['href']}
   self.links = (all_links.select { |link| link.value =~ reg_exp}).map {|link| link.value}
  end
end







