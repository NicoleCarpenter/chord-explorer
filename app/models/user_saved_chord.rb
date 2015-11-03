class UserSavedChord < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :chord

  def self.search(params)
      formatted_params = params[:search].split(",")[1..-1].map!{|chord| chord.strip}
      chord_objects = formatted_params.map{|chord| Chord.find_by(name: chord.strip).id}
      # @tabs = Tab.find_all_for_chords(chord_objects)
      # @tabs = Tab.group_tabs_by_artist(@tabs)
  end

end
