class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :url
      t.integer :rating
      t.integer :click_count
      t.text :raw_html
      t.integer :song_id

      t.timestamps null: false
    end
  end
end
