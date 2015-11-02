module ApplicationHelper
  def next_chord(bin_repertoire)
    current_playable_count = Tab.playables(bin_repertoire).count
    best_chord = nil
    Chord.count.times do |i|
      new_string = bin_repertoire.dup
      new_string[i] = 1
      best_chord = i unless Tab.playables(new_string) < current_playable_count
    end
    Chord.find(best_chord)
  end
end
