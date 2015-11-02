require 'nokogiri'

# This goes to ultimate guitar and finds you every artist they have.

doc = File.open("../tmp/ult-guitar-html/master.html") { |f| Nokogiri::HTML(f) }
output = File.open("../../db/missing.txt", "w")
doc.xpath('//a[starts-with(@href, "/tabs/")]').each { |x| output.write("https://www.ultimate-guitar.com"+x['href']+"\n") }