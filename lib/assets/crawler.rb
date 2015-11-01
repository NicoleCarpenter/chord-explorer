require 'anemone'

def crawl(link,like_pattern,skip_pattern)
  rand = Random.new
  new_file = File.open("url_list.txt", "w")
  Anemone.crawl(link) do |anemone|
    p "Attempting to navigate..."
    anemone.skip_links_like(skip_pattern)
    anemone.on_pages_like(like_pattern) do |page|
      p "Hey this matches our pattern: #{page.url}"
      new_file.write("#{page.url}\n")
    end
    anemone.on_every_page do |page|
      timer = rand(10) + 10
      p "Sleeping for #{timer} seconds"
      sleep(timer)
    end
  end
  new_file.close
end


crawl("http://www.ultimate-guitar.com",/.*_crd.htm/,/.*\/columns\/.*|.*\/reviews\/.*|.*\/news\/.*|.*_tab.htm|.*\/forum.*|.*\/updates.*|.*\/interviews.*|.*\/contests.*|.*\/lessons.*|.*\.com\/news\/.*|.*\.com\/lessons.*/)
