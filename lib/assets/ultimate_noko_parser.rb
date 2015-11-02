require 'json'
require 'pathname'

module UltimateNokoParser
  def self.parse(noko_object, url)
    song_data = {
      url: url,
      chords: get_chords(noko_object),
      title: get_title(noko_object),
      artist: get_artist(noko_object),
      ranking: get_ranking(noko_object),
      contributor: get_contributor(noko_object),
      ult_guitar_reviewcount: get_reviewcount(noko_object),
      ult_guitar_viewcount: get_viewcount(noko_object),
    }
    dump_json(song_data)
    p song_data
  end

  def self.get_chords(noko_object)
    chords = []
    noko_object.css("pre span").children.each do |span|
      chords << span.text
    end
    chords
  end

  def self.get_title(noko_object)
    noko_object.css("h1").text[0..-8]
  end

  def self.get_artist(noko_object)
    noko_object.css(".t_autor a").text
  end

  def self.get_ranking(noko_object)
    noko_object.css(".vote-success").text
  end

  def self.get_contributor(noko_object)
    noko_object.css(".t_dtde").text
  end

  def self.get_viewcount(noko_object)
    noko_object.css(".stats").text
  end

  def self.get_reviewcount(noko_object)
    noko_object.css(".v_c").text
  end

  def self.dump_json(song_data)
    artist = song_data[:artist].gsub(" ", "_")
    if artist
      output_file = File.open(Pathname.new("../../db/artists/#{artist[0].downcase}/#{artist}.txt"), 'a')
      JSON.dump(song_data, output_file)
      output_file.write("\n")
      output_file.close
    end
  end
end
