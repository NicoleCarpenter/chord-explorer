module ApplicationHelper
  def next_chord(bin_repertoire)
    current_playable_count = Tab.playables(bin_repertoire).count
    best_chord = ni
    Chord.count.times do |i|
      new_string = bin_repertoire.dup
      new_string[i] = 1
      if Tab.playables(new_string) > current_playable_count
        best_chord = i
        current_playable_count = Tab.playables(new_string).count
      end
    end
    Chord.find(best_chord)
  end
end
