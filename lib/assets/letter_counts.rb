require 'nokogiri'
require 'anemone'
require_relative 'ultimate_noko_parser'
require_relative 'html_white_space_cleaner'

def fetch!(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port) #create a new HTTP request
  request = Net::HTTP::Get.new(uri.request_uri) #create a get request
  request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36"}) #set headers
  response = http.request(request) #make the request
  clean_html_string = HTMLWhitespaceCleaner.clean(response.body)
end

letter_counts = {
                "a" => 79,
                "b" => 64,
                "c" => 67,
                "d" => 66,
                "e" => 40,
                "f" => 37,
                "g" => 39,
                "h" => 33,
                "i" => 20,
                "j" => 65,
                "k" => 34,
                "l" => 70,
                "m" => 80,
                "n" => 30,
                "o" => 17,
                "p" => 49,
                "q" => 3,
                "r" => 51,
                "s" => 94,
                "t" => 109,
                "u" => 8,
                "v" => 18,
                "w" => 20,
                "x" => 3,
                "y" => 9,
                "z" => 7
}

letter_counts.each do |letter, page_count|
  puts "Working on #{letter}"
  (1..page_count).each do |i|
    output = File.open("#{letter}#{i}.html", "w")
    url = "http://www.ultimate-guitar.com/bands/#{letter}#{i}.htm"
    clean_html_string = fetch!(url)
    output.write(clean_html_string)
    puts "Just wrapped up #{i}"
    sleep(3)
  end
end