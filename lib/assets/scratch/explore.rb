#Use nokogiri to navigate to https://www.ultimate-guitar.com/top/top100.htm
#Scrape html from the site and pull all the links.
#Use nokogiri to navigate to each page.
#Scrape the chords

require 'nokogiri'
require 'open-uri'



doc = Nokogiri::HTML(open("https://www.ultimate-guitar.com/top/top100.htm"))
class Page
  def initialize(url)

  end

  def fetcht!
    raw_html_string = Net::HTTP.get(URI(@url))
    clean_string_html = HTML
end
