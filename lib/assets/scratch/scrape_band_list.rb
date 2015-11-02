require 'anemone'

def focus(link)
  output_file = File.open("output2.txt", "w")
  rand = Random.new
  Anemone.crawl(link) do |anemone|
    puts "sleeping"
    anemone.focus_crawl do |page|
      # p page.links.select { |link| link.to_s.match(/https:\/\/www.ultimate-guitar\.com\/bands\/[a-z]\d*\.htm/) }
      page.links.select do |link|
        link.to_s.match(/https:\/\/www.ultimate-guitar\.com\/bands\/[a-z]\d*\.htm/)
      end

    end

    anemone.on_every_page do |page|

      p "We're at #{page.url}"

      band_links = page.links.select { |link| link.to_s =~ /.*ultimate-guitar.com\/tabs\/.*/ }

      band_links.each do |link|
        puts "    #{link}"
        output_file.write(link.to_s+"\n")
      end

    end
  end
  output_file.close
end



focus("https://www.ultimate-guitar.com/bands/a.htm")
