require 'anemone'


def crawl(link,like_pattern,skip_pattern)
  rand = Random.new
  Anemone.crawl(link) do |anemone|
    p "Attempting to navigate..."
    anemone.skip_links_like(skip_pattern)
    anemone.on_pages_like(like_pattern) {|page| p "Hey this matches our pattern: #{page.url}" }
    anemone.on_every_page do |page|
      timer = rand(10) + 10
      p "Sleeping for #{timer} seconds"
      sleep(timer)
    end
  end
end


crawl("https://www.ultimate-guitar.com/tabs/lady_gaga_tabs.htm",/.*_crd.htm/,/.*\/columns\/.*|.*\/reviews\/.*|.*\/news\/.*|.*_tab.htm|.*\/forum.*|.*\/updates.*|.*\/interviews.*|.*\/contests.*|.*\/lessons.*|.*\.com\/news\/.*|.*\.com\/lessons.*/)
