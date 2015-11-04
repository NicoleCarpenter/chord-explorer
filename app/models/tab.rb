class Tab < ActiveRecord::Base
  has_many    :included_chords
  has_many    :chords, through: :included_chords
  belongs_to  :song
  validate :include_proper_chords?
  paginates_per 10

  def self.search(params)
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(escaped_name: chord.strip).id}
      @tabs = Tab.find_all_for_chords(chord_objects)
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

  def show_chords
    included_chords.map(&:chord).map(&:name)
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
      unless proper_chords.include?(chord)
        errors.add(:chord, "This chord isn't in our database")
      end
    end
  end
end

# song1 = [1,4,27]
# song2 = [1,4,27,63]
# song3 = [63, 84]
# song4 = [4,27,84]
# # song5 = [1,4]

# [song1, song2, song4, song5]


# [song1, song5]

# select tab_id
# from included_chords
# where chord_id NOT IN ()
