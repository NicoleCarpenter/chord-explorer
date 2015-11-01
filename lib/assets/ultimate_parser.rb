require 'nokogiri'

module UltimateParser
	
	def self.parse(html_string)
		chords = []
		noko_object = Nokogiri.parse(html_string)
		noko_object.css("pre span").children.each do |span|
			chords << span.text
		end
		chords
	end

end

test = File.open("hello_test.txt","r").read

chords = UltimateParser.parse(test)

chords.each {|el| p el}