class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song
  validate :include_proper_chords?, :has_sequence?
  validates :url, uniqueness: true

  @@chord_mapper = YAML.load(File.open("db/canonical_chords.yaml", "r").read)

  def self.search(params)
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(escaped_name: chord.strip).id}
      @tabs = Tab.find_all_for_chords(chord_objects)
      @tabs = @tabs.order(view_count: :desc)
      @tabs = Tab.group_tabs_by_artist(@tabs)
  end

  def self.group_tabs_by_artist(tabs)
    grouped = tabs.group_by { |x| x.song }
  end

  def self.find_all_for_chords(chord_ids)
    where(<<-SQL, ids: chord_ids)
      tabs.id IN (
        SELECT DISTINCT tab_id
        FROM included_chords
        WHERE chord_id IN (:ids)
        EXCEPT
        SELECT DISTINCT tab_id
        FROM included_chords
        WHERE chord_id NOT IN (:ids)
      )
    SQL
  end

  #included_chords.map(&:chord) is returning nil chords, so we used compact on it.
  def show_chords
    included_chords.map(&:chord).compact.map(&:name)
  end

  def playable?(song_chords, your_chords)
    # Arguments will be strings of binary, representing booleans.
    (song_chords.to_i(2) & your_chords.to_i(2) == song_chords.to_i(2))
  end

  def self.playables(your_chords)
    all.select {|tab| tab.playable?(tab.binary_chords, your_chords)}
  end

  private

  #validations

  def include_proper_chords?
    proper_chords = Chord.all.pluck(:name)
    sequence.uniq.each do |chord|
      chord = @@chord_mapper.fetch(chord, chord)
      unless proper_chords.include?(chord)
        errors.add(:chord, "This chord isn't in our database")
      end
    end
  end

  def has_sequence?
    errors.add(:song, "Tab doesn't have a chord sequence") unless sequence.uniq.length > 1
  end
end
