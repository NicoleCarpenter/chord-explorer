class AddSequenceToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :sequence, :text, options = {array: true, default: []} 
  end
end
