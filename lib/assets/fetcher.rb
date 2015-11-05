require 'yaml'

module Fetcher

  def fetch!(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port) #create a new HTTP request
    request = Net::HTTP::Get.new(uri.request_uri) #create a get request
    request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36"}) #set headers
    response = http.request(request) #make the request
    clean_html_string = HTMLWhitespaceCleaner.clean(response.body)
  end
  
  def self.get_em(file_name)
    output = File.open("artist_links", "w")
    link_list = parse_file(file_name)
    link_list.map! do |link|
      puts "Focusing on #{link}"
      focus(link)
    end
    output.write(YAML.dump(link_list))
    output.close
    link_list
  end

  def self.parse_file(file_name)
    file = File.open(file_name,"r")
    file.readlines.map(&:chomp)
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
        # Ignoring some garbage-y sort links.
        pagination_links << page.url.to_s.sub(/s/, "") unless page.url.to_s.include?("htm?sort=date")
      end
    end
    pagination_links
  end
end


#For each link provided via Fetcher.get_em
#Visit each link and grab appropriate links to songs and put into array
#Deliver list of songs to ArtistCrawler
