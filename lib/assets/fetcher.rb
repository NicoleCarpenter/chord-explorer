module Fetcher
  def self.get_em(file_name)
    link_list = parse_file(file_name)
    link_list.map! do |link| 
      puts "Focusing on #{link}"
      focus(link)
    end
    link_list
  end

  def self.parse_file(file_name)
    file = File.open(file_name,"r")
    derp = file.readlines.map(&:chomp)
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
