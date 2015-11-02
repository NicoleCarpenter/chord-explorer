require 'yaml'
require_relative 'artist_scrape'
require_relative 'fetcher'

# Here we make sure the user has the proper folder structure to contain the scraped JSON objects.
p Dir.pwd

# Sample usage
# On the next line, replace text with your name.
# artist_lists = Fetcher.get_em('scraper_links/andy.txt')

# If you've already run the crawler once and it has errored, you shouldn't have to run line 10 again! Go ahead and comment out 10 and uncomment line 30.
artist_lists = YAML.load_file('artist_links')

artist_lists.each do |list|
  ArtistSongCrawler.new(list)
end
