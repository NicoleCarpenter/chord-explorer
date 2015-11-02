require 'nokogiri'

class Web_Tab
  def initialize(anemone_page=false,url=false)
    if anemone_page
      @url = anemone_page.url
      @noko_doc = anemone_page.doc
    end
    if url
      @url = url
      @noko_doc = fetch!(url)
    end
    @chords = []
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

  def get_chords
    @noko_doc.css(".print-visible").next_element().css("pre")
  end


end



