class CreateUltimateRaw < ActiveRecord::Migration
  def change
    create_table :ultimate_raws do |t|
      t.string :url
      t.string :raw_html
      t.timestamps null: false
    end
  end
end
